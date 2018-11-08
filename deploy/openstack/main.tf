resource "openstack_compute_keypair_v2" "tbneodb" {
  name       = "tbneodb"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "openstack_networking_network_v2" "tbneodb" {
  name           = "tbneodb"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "tbneodb" {
  name            = "tbneodb"
  network_id      = "${openstack_networking_network_v2.tbneodb.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4", "192.168.2.75", "192.168.2.8"]
}

resource "openstack_networking_router_v2" "tbneodb" {
  name                = "tbneodb"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.tbneodb.id}"
}

resource "openstack_networking_router_interface_v2" "tbneodb" {
  router_id = "${openstack_networking_router_v2.tbneodb.id}"
  subnet_id = "${openstack_networking_subnet_v2.tbneodb.id}"
}

resource "openstack_networking_floatingip_v2" "tbneodb" {
  pool = "${var.pool}"
}

resource "openstack_compute_instance_v2" "tbneodb" {
  name            = "tbneodb"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${openstack_compute_keypair_v2.tbneodb.name}"
  security_groups = ["default", "${openstack_networking_secgroup_v2.tbneodb.name}"]

  network {
    uuid = "${openstack_networking_network_v2.tbneodb.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "tbneodb" {
  floating_ip = "${openstack_networking_floatingip_v2.tbneodb.address}"
  instance_id = "${openstack_compute_instance_v2.tbneodb.id}"

  connection {
    host        = "${openstack_networking_floatingip_v2.tbneodb.address}"
    user        = "${var.ssh_user_name}"
    private_key = "${file(var.ssh_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
      "sudo apt-get remove docker docker-engine docker.io",
    ]
  }

  provisioner "remote-exec" {
    script = "./install-docker.sh"
  }

  # provisioner "local-exec" {
  #   command = "ssh ${var.ssh_user_name}@${openstack_networking_floatingip_v2.tbneodb.address} 'screen -dm bash -c \"sleep 5; sudo shutdown -r now\"; exit'"
  # }

  provisioner "remote-exec" {
    script = "./deploy.sh"
  }
}
