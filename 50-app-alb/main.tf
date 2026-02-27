module "alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = ture # for Private Subnet

  #expense-dev-app-alb  this is the Basic Load BALANCER Script
  name    = "${var.project_name}/${var.environment}-app-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.private.subnet_ids
  create_security_group = false
  security_groups = [local.app_alb_sg_id] # For List Purpose the local variable put in the bracktes 

  tags = merge (
    var.common_tags,
    {
        Name = "${var.project_name}/${var.environment}-app-alb"
    }
  )
}
