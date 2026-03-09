resource "aws_instance" "backend" {
  ami                    = data.aws_ami.joindevops.id
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  subnet_id =  local.private_subnet_id
  instance_type          = "t3.micro"
  

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-backend"

    }
  )
}
resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_ids = aws_instance.backend.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.backend.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }
  # Copy The Script to run 
  provisioner "file" {
    source = "backend.sh"
    destination = "/tmp/backend.sh" # it is Put in the .pem file in Server
    
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
       "chmod +x = /tmp/backend.sh",
       "sudo sh /tmp/backend.sh  ${var.environment}" # it is executed in the Server
    ]
  }
}
