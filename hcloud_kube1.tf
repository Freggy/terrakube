resource "hcloud_server" "kube1" {
  name        = "kube1"
  image       = "debian-9"
  server_type = "cx11"
  provisioner "remote-exec" {
    inline = ["sudo apt-get install -y python"]
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.ssh_key)}"
    }
  } 
  provisioner "local-exec" {
    command = "ansible-playbook -u root -i ${hcloud_server.kube1.ipv4_address} --private_key ${var.ssh_key} docker-install.yml"
  }
}

resource rke_cluster "cluster" {
  nodes {
    address = "${hcloud_server.kube1.ipv4_address}"
    user = "rancher"
    role = ["controlplane", "worker", "etcd"]
  }
}
