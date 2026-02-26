# main.tf — S03 : Première instance EC2

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3" # Paris
}

# --- Recherche de l'AMI Ubuntu 24.04 la plus récente ---
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (éditeur d'Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# --- Security Group : autoriser SSH ---
resource "aws_security_group" "novasphere_ssh" {
  name        = "novasphere-allow-ssh" # TODO 3 : Donnez un nom descriptif
  description = "Allow SSH from everywhere"

  ingress {
    description = "SSH"
    from_port   = 22 # TODO 4 : Quel port pour SSH ?
    to_port     = 22 # TODO 4 : Même port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 = tous les protocoles
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "novasphere-ssh"
    Project = "NovaSphere"
  }
}

# --- Instance EC2 ---
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro" # TODO 5 : Quel type d'instance économique ?
  
  vpc_security_group_ids = [aws_security_group.novasphere_ssh.id]

  tags = {
    Name    = "novasphere-web"
    Project = "NovaSphere"
    Session = "S03"
    Environment = "dev"
  }
}

# --- Outputs : afficher les infos utiles après apply ---
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Adresse IP publique"
  value       = aws_instance.web.public_ip # TODO 6 : Quel attribut pour l'IP publique ?
}

output "ami_used" {
  description = "AMI used"
  value       = data.aws_ami.ubuntu.id
}
