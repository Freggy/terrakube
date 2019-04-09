variable "hcloud_token" {}
variable "ssh_key" {}
variable "pub" {}

provider "hcloud" {
  token = "${var.hcloud_token}"
}
