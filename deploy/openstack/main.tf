resource "openstack_compute_keypair_v2" "combat_tb_db" {
  name       = "combat_tb_db"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "openstack_networking_network_v2" "combat_tb_db" {
  name           = "combat_tb_db"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "combat_tb_db" {
  name            = "combat_tb_db"
  network_id      = "${openstack_networking_network_v2.combat_tb_db.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4", "192.168.2.75", "192.168.2.8"]
}

resource "openstack_networking_router_v2" "combat_tb_db" {
  name                = "combat_tb_db"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.combat_tb_db.id}"
}

resource "openstack_networking_router_interface_v2" "combat_tb_db" {
  router_id = "${openstack_networking_router_v2.combat_tb_db.id}"
  subnet_id = "${openstack_networking_subnet_v2.combat_tb_db.id}"
}

resource "openstack_networking_floatingip_v2" "combat_tb_db" {
  pool = "${var.pool}"
}

resource "openstack_compute_instance_v2" "combat_tb_db" {
  name            = "combat_tb_db"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${openstack_compute_keypair_v2.combat_tb_db.name}"
  security_groups = ["default", "${openstack_networking_secgroup_v2.combat_tb_db.name}"]

  network {
    uuid = "${openstack_networking_network_v2.combat_tb_db.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "combat_tb_db" {
  floating_ip = "${openstack_networking_floatingip_v2.combat_tb_db.address}"
  instance_id = "${openstack_compute_instance_v2.combat_tb_db.id}"

  connection {
    host        = "${openstack_networking_floatingip_v2.combat_tb_db.address}"
    user        = "${var.ssh_user_name}"
    private_key = "${file(var.ssh_key_file)}"
  }

  # copy repository
  provisioner "file" {
    source      = "../../../combat-tb-db"
    destination = "."
  }

  # install docker and deploy database
  provisioner "remote-exec" {
    script = "./deploy.sh"
  }
}
