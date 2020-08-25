### Curso Linux Servers – Configuration & DevOps
------------

[![Ansible Galaxy](https://img.shields.io/badge/Ansible%20Galaxy-wluisaraujo-blue.svg)](https://galaxy.ansible.com/wluisaraujo)


Descrição
------------

Praticas do ambiente do curso [x52 Linux Servers – Configuration & DevOps](https://www.4linux.com.br/curso/linux-servers-configuration-devops)



Requisitos
------------

	Será utilizado Máquinas Virtuais para permitir ao aluno realizar o crso em qualquer computador ou sistema operacional e compatibilidade com VirtualBox.
	Você precisará baixar os Appliances e importá-lo no VirtualBox.

* [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads) versão 6 ou mais atual

* [Oracle VM VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)

* [Curso 752 Parte 01](https://storage.googleapis.com/4752-repositorio/Curso-4752-P1.ova)
* [Curso 752 Parte 02](https://storage.googleapis.com/4752-repositorio/Curso-4752-P2.ova)
* [Curso 752 Parte 03](https://storage.googleapis.com/4752-repositorio/Curso-4752-P3.ova)

* [Vagrant](https://www.vagrantup.com/docs/installation/)

* [Vagrant Plugins vagrant-disksize & vagrant-vbguest](https://www.vagrantup.com/docs/plugins/usage.html)

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

* [Docker](https://docs.docker.com/engine/install/)


Ambiente
--------------

vm|sitema|hostname|address
--- | --- | --- | ---:
Cliente-Externo | Debian 9 | backend.exemplo.com.br | 200.100.50.150
DevOps | Ubuntu 18.04 | middleware.exemplo.com.br | 200.100.50.242
Lab-Gamification | Debian 9 | frontend.exemplo.com.br | 172.16.100.210
Mail-Server | Debian 9 | workstation.exemplo.com.br | 172.16.100.206
Proxy-Server | CentOS 7 | workstation.exemplo.com.br | 172.16.100.205
Security | Ubuntu 18.04 | workstation.exemplo.com.br | 172.16.100.201
Storage | Debian 9 | workstation.exemplo.com.br | 172.16.100.202
Web-Server01 | Debian 9 | workstation.exemplo.com.br | 172.16.100.203
Web-Server02 | Ubuntu 18.04 | workstation.exemplo.com.br | 172.16.100.204


Aula | Conteúdo Programático | Playbook
--- | --- | ---
Aula 01 | Gerenciando o Firewall | [aula01.yml](playbooks/aula01.yml)
Aula 02 | DNS Server | [aula02.yml](playbooks/aula02.yml)
Aula 03 | LDAP Server | [aula03.yml](playbooks/aula03.yml)
Aula 04 | Compartilhamento em Rede | [aula04.yml](playbooks/aula04.yml)
Aula 05 | Database Server | [aula05.yml](playbooks/aula05.yml)
Aula 06 | Mail Server | [aula06.yml](playbooks/aula06.yml)
Aula 07 | VPN Server | [aula07.yml](playbooks/aula07.yml)
Aula 08 | Web Server | [aula08.yml](playbooks/aula08.yml)
Aula 09 | Load Balancer com Nginx | [playbooks/aula09.yml](aula09.yml)
Aula 10 | Proxy Server com Squid 3 | [playbooks/aula11.yml](aula10.yml)
Aula 11 | Gerenciar ambientes com Ansible | [playbooks/aula10.yml](aula11.yml)
Aula 12 | Planejamento de Capacidade | [playbooks/aula12.yml](aula12.yml)


Variáveis
--------------

domain:	
```yaml
domain: dexter.com.br


```

Dependências
------------

* Appliance devidamente configurado
* Ansible versão 2 ou mais atual
* Configurar interface vboxnet0 com ip 200.100.50.254 e associar ao host X
* Configurar interface vboxnet1 com ip 172.16.100.254 e associar ao host Y

Exemplo de uso do Ansible
----------------

```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml --check
```

##### Exemplo de uso configurando FIREWALL
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l security -t FIREWALL -C
```

##### Exemplo de uso configurando DNS
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l "web01,web02" -t DNS -C
```

##### Exemplo de uso configurando LDAP
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l storage -t LDAP -C
```

##### Exemplo de uso configurando SHARE
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l localhost -t SHARE -C
```

##### Exemplo de uso configurando DATABASE
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l localhost -t DATABASE -C
```

##### Exemplo de uso configurando MAIL
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l localhost -t MAIL -C
```

##### Exemplo de uso configurando VPN
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l localhost -t VPN -C
```

##### Exemplo de uso configurando APACHE
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l localhost -t APACHE -C
```

##### Exemplo de uso configurando NGINX
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l localhost -t NGINX -C
```

##### Exemplo de uso configurando SQUID
```console
vagrant@localhost:~$ ansible-playbook -i inventory.yml -u suporte -b -k -K main.yml -l security -t SQUID -C
```

Exemplo de uso do Vagrant
----------------

### Instalar o plugin do vagrant

```console
user@localhost:~$ vagrant plugin install vagrant-disksize
```

```console
user@localhost:~$ vagrant plugin install vagrant-vbguest
```

### Ajustar intefaces host only no virtualbox

```console
user@localhost:~$ bash script/vboxmanage-nic.sh
```

### Iniciar Vagrant

```console
user@localhost:~$ vagrant init
```
### Criar a VM via vagrant no virtualbox

```console
user@localhost:~$ vagrant up --provision
```

### Para acessar cada VM via SSH

```console
user@localhost:~$ vagrant ssh backend
```

### Para desligar as VMs

```console
user@localhost:~$ vagrant halt
```


### Para remover as VMs

```console
user@localhost:~$ vagrant destroy
```


----------------
[![Licence](https://img.shields.io/badge/License-GPL%20v3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.pt-br.html)
