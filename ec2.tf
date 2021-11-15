provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "public-web-ec2" {
  ami                         = "ami-0567e0d2b4b2169ae"
  instance_type               = "t3a.micro"
  availability_zone           = "ap-south-1a"
  key_name                    = "sonarqube"
  subnet_id                   = "subnet-099c5c4757d183892"
  vpc_security_group_ids      = ["sg-0e416834b5a06dec8"]
  associate_public_ip_address = true

}

resource "local_file" "tf_ansible_vars_file_new" {
  content  = <<-DOC
    # Ansible vars_file containing variable values from Terraform.
    # Generated by Terraform mgmt configuration.
    tf_public_dns_name: ${aws_instance.public-web-ec2.public_dns}
    tf_public_ip: ${aws_instance.public-web-ec2.public_ip}
    DOC
  filename = "./tf_ansible_vars_file.yml"
}
