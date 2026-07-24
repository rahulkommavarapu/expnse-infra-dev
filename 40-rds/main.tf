module "db" {
  source = "terraform-aws-modules/rds/aws"
  version = "5.7.0"

  identifier = local.resource_name #expense-dev


  engine            = "mysql"
  engine_version    = "8.0.40"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = "transactions" # Aws Will Create the Schema Automatically
  username = "root"
  port     = "3306"
  #password = "ExpenseApp1"

 # manage_master_user_password = false # here the Value is given TRUE There is NO need to give the password ,terraform automatically store the password in SECRETE MANAGER.
  vpc_security_group_ids      = [local.mysql_sg_id]

  # DB subnet group
  create_db_subnet_group = false # Now it is Created by one time itself in the Projects
  db_subnet_group_name   = local.database_subnet_group_name

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false
  skip_final_snapshot = true # for Auto Delete Snapshots 

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    }

  ]
  tags = merge(
    var.common_tags,
    {
      Name = local.resource_name
    }
  )
}
# Create the record for RDS  (terraform aws CNAME Route53 Record )
resource "aws_route53_record" "www-dev" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 5
  records = [module.db.db_instance_address]
}
