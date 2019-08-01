# DemoUTEC

Pasos:
NOTA: Pararse dentro del carpeta root del git.

1. Correr terraform (parado dentro de terraform/mainA o mainB) `terraform apply`
1. Correr Ansible(dependiendo del grupo A o B) `ansible-playbook -i ansible/inventario/hosts ansible/mainA.yml`

Realizar un cambio en html a pedido de los chicos y realizar un re-respliegue. Archivo ansible/templates/index.html.j2
Mostrar cambios.

[Infraestructura como Código](https://xebialabs.com/periodic-table-of-devops-tools/)
