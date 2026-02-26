# main.tf — S03 : Premier déploiement Terraform

terraform {
  required_providers {
    local = {
      # TODO 1: The standard source for the local provider
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {
  # Configuration options go here if needed
}

resource "local_file" "novasphere_welcome" {
  # TODO 2: The content you want inside the text file
  content  = "NovaSphere -- Infrastructure as Code v2.0"
  filename = "${path.module}/welcome.txt"
}
