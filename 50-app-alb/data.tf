
# Vpc_id
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}
# private Subnet_ids
data "aws_ssm_parameter" "Private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/Private_subnet_ids"
}
# for refer the app_alb_sg_id 
data "aws_ssm_parameter" "app_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
}
