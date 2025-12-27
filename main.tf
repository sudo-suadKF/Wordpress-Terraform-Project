module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    public_subnet1_cidr = var.public_subnet1_cidr
    public_subnet2_cidr = var.public_subnet2_cidr
    private_subnet1_cidr = var.private_subnet1_cidr
    private_subnet2_cidr = var.private_subnet2_cidr
    az1 = var.az1
    az2 = var.az2
    internet_cidr = var.internet_cidr
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpc_id
    my_ip = var.my_ip
    internet_cidr = var.internet_cidr
}

module "alb" {
    source = "./modules/alb"
    public_subnet1_id = module.vpc.public_subnet1_id
    public_subnet2_id = module.vpc.public_subnet2_id
    alb_sg_id = module.sg.alb_sg_id
    cert_arn = module.acm.cert_arn
    vpc_id = module.vpc.vpc_id
    ec2_1_id = module.ec2_1.ec2_instance_id
    ec2_2_id = module.ec2_2.ec2_instance_id
}

module "route53" {
  source = "./modules/route53"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
  alb_domain_name = var.alb_domain_name
  hosted_zone_name = var.hosted_zone_name
}

module "acm" {
  source = "./modules/acm"
  hosted_zone_name = var.hosted_zone_name
  alb_domain_name = var.alb_domain_name
}

module "rds" {
    source = "./modules/rds"
    private_subnet1_id = module.vpc.private_subnet1_id
    private_subnet2_id = module.vpc.private_subnet2_id
    rds_sg_id = module.sg.rds_sg_id
    db_name = var.db_name
    username = var.username
    password = var.password
}

module "ec2_1" {
  source = "./modules/ec2"
  instance_subnet_id = module.vpc.public_subnet1_id
  key_name = var.key_name
  instance_ami = var.instance_ami
  instance_type = var.instance_type
  ec2_sg_id = module.sg.ec2_sg_id
  db_name = var.db_name
  username = var.username
  password = var.password
  rds_endpoint = module.rds.rds_endpoint
  rds_port = module.rds.rds_port
}

module "ec2_2" {
  source = "./modules/ec2"
  instance_subnet_id = module.vpc.public_subnet2_id
  key_name = var.key_name
  instance_ami = var.instance_ami
  instance_type = var.instance_type
  ec2_sg_id = module.sg.ec2_sg_id
  db_name = var.db_name
  username = var.username
  password = var.password
  rds_endpoint = module.rds.rds_endpoint
  rds_port = module.rds.rds_port
}




