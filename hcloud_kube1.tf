resource "hcloud_server" "kube1" {
  name        = "kube1"
  image       = "debian-9"
  server_type = "cx11"
}

resource rke_cluster "cluster" {
  nodes {
    address = "${hcloud_server.kube1.ipv4_address}"
    user = "rancher"
    role = ["controlplane", "worker", "etcd"]
  }
}
