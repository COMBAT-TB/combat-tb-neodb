resource "openstack_networking_secgroup_v2" "tbneodb" {
  name        = "tbneodb"
  description = "Security group for the tbneodb example instances"
}

resource "openstack_networking_secgroup_rule_v2" "tbneodb" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tbneodb.id}"
}

resource "openstack_networking_secgroup_rule_v2" "tbneodb_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tbneodb.id}"
}

resource "openstack_networking_secgroup_rule_v2" "tbneodb_80" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tbneodb.id}"
}

resource "openstack_networking_secgroup_rule_v2" "tbneodb_7474" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 7474
  port_range_max    = 7474
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tbneodb.id}"
}

resource "openstack_networking_secgroup_rule_v2" "tbneodb_7687" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 7687
  port_range_max    = 7687
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tbneodb.id}"
}

resource "openstack_networking_secgroup_rule_v2" "tbneodb_9200" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9200
  port_range_max    = 9200
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tbneodb.id}"
}

resource "openstack_networking_secgroup_rule_v2" "tbneodb_2376" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 2376
  port_range_max    = 2376
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tbneodb.id}"
}
