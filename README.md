# Terrakube
Project I use for playing around with Terraform and Ansible. This will install RKE on a VM in Hetzner Cloud.

**Usage**
```
$ terraform apply \
  -var=hcloud_token=<token> \
  -var=private_key=<path/to/key> \
  -var=public_key=<name/fingerprint> \
```
