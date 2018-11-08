data "openstack_networking_network_v2" "tbneodb" {
  name = "${var.pool}"
}
