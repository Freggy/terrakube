resource "hcloud_server" "kube1" {
  name        = "kube1"
  image       = "debian-9"
  server_type = "cx11"
  ssh_keys = ["${var.pub}"]
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.ssh_key)}"
    }
  } 
  provisioner "local-exec" {
   command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -t docker -u root -i ${hcloud_server.kube1.ipv4_address}, --private-key ${var.ssh_key} docker-install.yml"
  }
}

resource rke_cluster "cluster" {
  nodes {
      address = "${hcloud_server.kube1.ipv4_address}"
      user    = "root"
      role    = ["controlplane", "worker", "etcd"]
      ssh_key = "${file(var.ssh_key)}"
  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = "${rke_cluster.cluster.kube_config_yaml}" 
}
