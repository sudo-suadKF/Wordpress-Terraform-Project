#EC2_instances
resource "aws_instance" "Wordpress_EC2_instance1" {
  ami = var.instance_ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.instance_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [ var.ec2_sg_id ]

  user_data = templatefile("${path.module}/cloudinit.sh", { 
    db_name      = var.db_name
    db_username  = var.username
    db_password  = var.password
    rds_endpoint = var.rds_endpoint
    rds_port     = var.rds_port
  })

tags = {
    Name = "WordpressEc2Instance1"
  }
}