
# Create the Module for Apllicaton Load Balancer
module "alb" {
  source   = "terraform-aws-modules/alb/aws"
  internal = true # for Private Subnet

  #expense-dev-app-alb  this is the Basic Load BALANCER Script
  name                  = "${var.project_name}-${var.environment}-app-alb"
  vpc_id                = data.aws_ssm_parameter.vpc_id.value
  subnets               = local.private_subnet_id
  create_security_group = false
  security_groups       = [local.app_alb_sg_id] # For List Purpose the local variable put in the bracktes 

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-app-alb"
    }
  )
}

# aws-alb-listner for terraform We create the Application Load Balancer Listener Here

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>HI,My name is Rahul Kommavarapu i am from Backend APP ALB</h1>"
      status_code  = "200"
    }
  }
}

# Create the Route53 Record for Domain NAME System 
resource "aws_route53_record" "app_alb" {
  zone_id = var.zone_id
  name    = "*.app-dev.${var.domain_name}"
  type    = "A"
  # this are the Application Load Balancer name and zone information
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}
