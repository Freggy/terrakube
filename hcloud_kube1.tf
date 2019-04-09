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
