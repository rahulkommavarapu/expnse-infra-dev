
# Here Create the Instance with Backend Name 
resource "aws_instance" "backend" {
  ami                    = data.aws_ami.joindevops.id
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  subnet_id              = local.private_subnet_id
  instance_type          = "t3.micro"


  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-backend"

    }
  )
}
# it exactly like resource but it not create any resource, for copying the files and run resources
resource "null_resource" "backend" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = aws_instance.backend.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = aws_instance.backend.private_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  }
 provisioner "file"{
    source = "backend.sh"
    destination = "/tmp/backend.sh" # it is put in the pem file in server

 }
  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
        "chmod +x /tmp/backend.sh",
        "sudo sh /tmp/backend.sh ${var.environment}"
    ]
  }
}
