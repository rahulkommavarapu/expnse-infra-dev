
module "mysql_sg" {
  source         = "git::https://github.com/rahulkommavarapu/terraform-aws-securitygroup.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "mysql"
  sg_description = "Created for mysql instances expense dev"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
}

module "backend_sg" {
  source         = "git::https://github.com/rahulkommavarapu/terraform-aws-securitygroup.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "backend"
  sg_description = "Created for backend instances expense dev"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
}

module "frontend_sg" {
  source         = "git::https://github.com/rahulkommavarapu/terraform-aws-securitygroup.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "frontend"
  sg_description = "Created for frontend instances expense dev"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags

}

# Security Group for Bastion Purpose 
module "bastion_sg" {
  source         = "git::https://github.com/rahulkommavarapu/terraform-aws-securitygroup.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "bastion"
  sg_description = "Created for bastion instances expense dev"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  
}
# Create Security Group app-alb
module "app_alb_sg" {
  source         = "git::https://github.com/rahulkommavarapu/terraform-aws-securitygroup.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "app-alb"
  sg_description = "Created for backend ALB for instances expense dev"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  
}
