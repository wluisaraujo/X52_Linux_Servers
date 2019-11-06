### Curso Linux Servers – Configuration & DevOps
------------

[![Ansible Galaxy](https://img.shields.io/badge/Ansible%20Galaxy-wluisaraujo-blue.svg)](https://galaxy.ansible.com/wluisaraujo)


Descrição
------------

	Curso Linux Servers – Configuration & DevOps

Requisitos
------------

* [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads) versão 6 ou mais atual

* [Oracle VM VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)

* [Vagrant](https://www.vagrantup.com/docs/installation/)

* [Vagrant Plugins vagrant-disksize & vagrant-vbguest](https://www.vagrantup.com/docs/plugins/usage.html)

Variáveis
--------------

domain:	
```yaml
domain: exemplo.com.br
```

Dependências
------------

* Configurar interface vboxnet0 com ip 200.100.50.254 e associar ao host X
* Configurar interface vboxnet1 com ip 172.16.100.254 e associar ao host Y

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

Exemplo
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
