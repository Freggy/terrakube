resource "hcloud_server" "kube1" {
  name        = "kube1"
  image       = "debian-9"
  server_type = "cx11"
}
