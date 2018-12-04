data "openstack_networking_network_v2" "combat_tb_db" {
  name = "${var.pool}"
}
