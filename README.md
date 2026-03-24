# NovaSphere — Infrastructure as Code

## Description

Dépôt d'infrastructure de NovaSphere.
Provisioning via Terraform, configuration via Ansible.

## Stack

- **Provisioning** : Terraform 1.14+ (provider AWS)
- **Configuration** : Ansible 2.17+ (via pipx)
- **Cloud** : AWS (EC2, VPC, Security Groups, IAM)
- **Image Building** : Packer 1.11+ (AMI)

## Structure du dépôt

```
novasphere-infra/
├── ansible/
│   ├── ansible.cfg              # Configuration Ansible
│   ├── inventory/hosts.yml      # Inventaire des hôtes
│   ├── group_vars/              # Variables par groupe
│   ├── playbook.yml             # Playbook principal
│   └── roles/
│       ├── common/              # Rôle : tâches communes (apt update…)
│       └── webserver/           # Rôle : Nginx + app NovaSphere
├── terraform/
│   ├── aws/                     # Infra AWS de production
│   ├── lab-aws/                 # Lab AWS
│   └── lab-local/               # Lab local
├── docs/                        # Documentation d'architecture
└── .env                         # Variables d'environnement (non versionné)
```
