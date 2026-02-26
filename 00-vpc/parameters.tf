resource "aws_ssm_parameter" "vpc_id" {
 name = "/${var.project_name}/${var.environment}/vpc_id"
 type = "String"
 value  = module.vpc.vpc_id
}

#Here Using Join Function for String to List join() function → List → String conversion
#Multiple values ని కలిపి ఒక single text గా చేయడం

resource "aws_ssm_parameter" "public_subnet_ids" {
 name = "/${var.project_name}/${var.environment}/public_subnet_ids"
 type = "StringList"
 value  = join (",",module.vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/private_subnet_ids"
    type = "StringList"
    value = join (",",module.vpc.private_subnet_ids)
  
}
resource "aws_ssm_parameter" "database_subnet_ids"{
    name = "/${var.project_name}/${var.environment}/database_subnet_ids"
    type = "StringList"
    value = join (",",module.vpc.database_subnet_ids)
}