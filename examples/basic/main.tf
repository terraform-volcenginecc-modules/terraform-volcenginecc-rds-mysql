module "mysql" {
  source  = "terraform-volcenginecc-modules/rds-mysql/volcenginecc"
  version = "~> 1.0"

  instance_name     = var.instance_name
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  db_engine_version = "MySQL_8_0"
  instance_type     = "SingleNode"
  storage_type      = "CloudESSD_PL0"
  storage_space_gb  = 100

  nodes = [
    {
      zone_id   = var.zone_id
      node_spec = var.node_spec
      node_type = "Primary"
    }
  ]

  charge_detail = {
    charge_type = "PostPaid"
  }

  deletion_protection = "Disabled"
  project_name        = var.project_name
}
