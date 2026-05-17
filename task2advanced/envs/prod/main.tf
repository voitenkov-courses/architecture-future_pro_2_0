resource "yandex_vpc_network" "test-network-prod" {
  name                        = "${var.project}-network-${var.environment}"
}

module "test-subnet-prod" {
  source                      = "../../modules/subnet"
  subnet_name                 = "${var.project}-subnet-${var.environment}-a1"
  subnet_network_id           = yandex_vpc_network.test-network-prod.id
  subnet_zone                 = var.zone
  subnet_v4_cidr_blocks       = var.subnet_v4_cidr_blocks

  depends_on = [yandex_vpc_network.test-network-prod]
}

module "test-vm-prod" {
  source                      = "../../modules/instance"
  count                       = 1
  instance_zone               = var.zone
  instance_no                 = count.index + 1
  instance_name               = "${var.project}-vm-${count.index + 1}-${var.environment}"
  instance_cores              = 2
  instance_memory             = 2
  instance_image_family       = "ubuntu-2204-lts"
  instance_disk_name          = "${var.project}-vm-${count.index + 1}-${var.environment}-disk"
  instance_disk_type          = "network-ssd"
  instance_subnet_id          = module.test-subnet-prod.id
  instance_nat                = true
  instance_user               = "ubuntu"

  depends_on = [module.test-subnet-prod]     
}
