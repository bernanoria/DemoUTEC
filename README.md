# DemoUTEC

Pasos:
NOTA: Pararse dentro del carpeta root del git.

1. Inicializar terraform, dentro de la carpeta terraform/mainX (A o B) `terraform init`
1. Correr terraform (parado dentro de terraform/mainA o mainB) `terraform apply`
1. Correr Ansible(dependiendo del grupo A o B) `ansible-playbook -i ansible/inventario/hosts ansible/mainA.yml`

[Infraestructura como Código](https://xebialabs.com/periodic-table-of-devops-tools/)
