# connect to aws
#==========================
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

# deploy ec2 instance with ubuntu ami
#==========================
resource "aws_instance" "webserver" {
  # Customized  my own centos, ex. selinux disabled as it is not production server, sshd config changed
  ami = "${var.ami_id}"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_http.id}"]
  key_name = "${var.ssh_key_name}"

  tags {
    Name = "Nosto devops test"
  }
}

# ----------------------------------------------------------------------------
# CREATE THE SECURITY GROUP THAT'S APPLIED TO THE EC2 INSTANCE
# ---------------------------------------------------------------------------

resource "aws_security_group" "allow_ssh_http" {
  name = "allow ssh and http port 80 traffic"
  description = "Allow inbound SSH and HTTP 80 traffic from any IP"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Allow SSH anf HTTP"
  }
}

