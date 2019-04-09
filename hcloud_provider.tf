variable "hcloud_token" {}
variable "ssh_key" {}

provider "hcloud" {
  token = "${var.hcloud_token}"
}
