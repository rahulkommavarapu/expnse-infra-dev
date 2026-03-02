variable "project_name" {
  default = "expense"

}
variable "environment" {
  default = "dev"

}

variable "common_tags" {
  default = {
    project     = "expense"
    environment = "dev"
    terraform   = "true"
  }
}
variable "zone_id"{
  default = "Z001854036XQKN6X4S0CB"
}
variable "domain_name" {
  default = "practice255.online"
}