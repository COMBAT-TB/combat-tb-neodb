variable "image" {
  default = "Ubuntu-xenial-16.04-amd64"
}

variable "flavor" {
  default = "ilifu-C"
}

variable "ssh_key_file" {
  default = "~/.ssh/vms"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "pool" {
  default = "Ext_Floating_IP"
}
