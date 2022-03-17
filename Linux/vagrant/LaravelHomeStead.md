# Path Relativo
Linux/vagrant/LaravelHomeStead.md

# Pasos Nuevos ya simplificados
## Primero Instalar Vagrant
https://www.vagrantup.com/downloads

- curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
- sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
- sudo apt-get update && sudo apt-get install vagrant

## Clonar laravel homestead
https://laravel.com/docs/9.x/homestead#first-steps

- git clone https://github.com/laravel/homestead.git ~/Homestead
- cd ~/Homestead
- git checkout release
- bash init.sh

The provider key in your Homestead.yaml file indicates which Vagrant provider should be used: virtualbox or parallels:
- provider: virtualbox

Configuring Shared Folders
The folders property of the Homestead.yaml file lists all of the folders you wish to share with your Homestead environment. As files within these folders are changed, they will be kept in sync between your local machine and the Homestead virtual environment. You may configure as many shared folders as necessary:
```php
folders:
    - map: ~/laravel/homestead
      to: /home/vagrant/code

sites:
    - map: homestead.test
      to: /home/vagrant/code/test/public
```

Configuring Services
```php
databases:
    - homestead

features:
    - mysql: true
    - mariadb: false
    - postgresql: false
    - ohmyzsh: false
    - webdriver: false

services:
    - enabled:
          - "mysql"
```

Archivo Homestead.yaml completo
```php
---
ip: "192.168.56.56"
memory: 2048
cpus: 2
provider: virtualbox

authorize: ~/.ssh/id_rsa.pub

keys:
    - ~/.ssh/id_rsa

folders:
    - map: ~/laravel/homestead
      to: /home/vagrant/code

sites:
    - map: homestead.poslite
      to: /home/vagrant/code/poslite/public
    
    - map: homestead.dominalaravel
      to: /home/vagrant/code/dominalaravel/public

    - map: homestead.livewire
      to: /home/vagrant/code/livewire/public
    
    - map: homestead.inventory
      to: /home/vagrant/code/inventory/public
    
    - map: homestead.restapi
      to: /home/vagrant/code/restapi/public

    - map: homestead.l7inventory
      to: /home/vagrant/code/l7inventory/public

    - map: homestead.school
      to: /home/vagrant/code/school/public

databases:
    - poslite
    - dominalaravel
    - livewire
    - inventory
    - restapi
    - l7inventory
    - school

features:
    - mysql: true
    - mariadb: false
    - postgresql: false
    - ohmyzsh: false
    - webdriver: false

services:
    - enabled:
          - "mysql"
#    - disabled:
#        - "postgresql@11-main"

#ports:
#    - send: 33060 # MySQL/MariaDB
#      to: 3306
#    - send: 4040
#      to: 4040
#    - send: 54320 # PostgreSQL
#      to: 5432
#    - send: 8025sudo # Mailhog
#      to: 8025
#    - send: 9600
#      to: 9600
#    - send: 27017
#      to: 27017


# Ejemplo de /etc/hosts que ya me funciono:

# 127.0.0.1	localhost
# 127.0.1.1	latitude

# The following lines are desirable for IPv6 capable hosts
# ::1     ip6-localhost ip6-loopback
# fe00::0 ip6-localnet
# ff00::0 ip6-mcastprefix
# ff02::1 ip6-allnodes
# ff02::2 ip6-allrouters

# homestead
# 192.168.56.56  homestead.test1
# 192.168.56.56  homestead.poslite

# Listo con esto ya puedo manejar multiples proyectos de laravel

# Si le hacemos algun cambio a /etc/hosts podemos hacer reload con:
# ```php
# > sudo service network-manager restart
# > vagrant provision
# ```

# Si le hacemos algun cambio al yml file:
# ```php
# > vagrant reload --provision
# o
# vagrant provision
# ```

# En Laravel
# DB_CONNECTION=mysql
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE=l7inventory
# DB_USERNAME=homestead
# DB_PASSWORD=secret
```

Homestead.yaml (segunda version)
```php
---
ip: "192.168.56.56"
memory: 2048
cpus: 2
provider: virtualbox

authorize: ~/.ssh/id_rsa.pub

keys:
    - ~/.ssh/id_rsa

folders:
    - map: ~/laravel/homestead
      to: /home/vagrant/code

sites:
    - map: homestead.test
      to: /home/vagrant/code/pruebas/test/public

    - map: homestead.livewire
      to: /home/vagrant/code/pruebas/livewire/public

databases:
    - homestead
    - livewire

features:
    - mysql: true
    - mariadb: false
    - postgresql: false
    - ohmyzsh: false
    - webdriver: false

services:
    - enabled:
          - "mysql"
#    - disabled:
#        - "postgresql@11-main"

#ports:
#    - send: 33060 # MySQL/MariaDB
#      to: 3306
#    - send: 4040
#      to: 4040
#    - send: 54320 # PostgreSQL
#      to: 5432
#    - send: 8025sudo # Mailhog
#      to: 8025
#    - send: 9600
#      to: 9600
#    - send: 27017
#      to: 27017


# Ejemplo de /etc/hosts que ya me funciono:
# ------------------------------
# 127.0.0.1	localhost
# 127.0.1.1	latitude

# 127.0.0.5	ecommerce.test

# The following lines are desirable for IPv6 capable hosts
# ::1     ip6-localhost ip6-loopback
# fe00::0 ip6-localnet
# ff00::0 ip6-mcastprefix
# ff02::1 ip6-allnodes
# ff02::2 ip6-allrouters

# homestead
# 192.168.56.56  homestead.test
# 192.168.56.56  homestead.livewire
--------------------------------

# Listo con esto ya puedo manejar multiples proyectos de laravel

# Si le hacemos algun cambio a /etc/hosts podemos hacer reload con:
# ```php
# > sudo service network-manager restart
# > vagrant provision
# ```

# Si le hacemos algun cambio al yml file:
# ```php
# > vagrant reload --provision
# o
# vagrant provision
# ```

# En Laravel
# DB_CONNECTION=mysql
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE=l7inventory
# DB_USERNAME=homestead
# DB_PASSWORD=secret
```

## Generar los private keys
generar los ssh keys
- ssh-keygen -t rsa -C "enrique@homestead"

## Launching The Vagrant Box
Once you have edited the Homestead.yaml to your liking, run the vagrant up command from your Homestead directory. 
- vagrant up

Vagrant will boot the virtual machine and automatically configure your shared folders and Nginx sites.
To destroy the machine, you may use the vagrant destroy command.
Listo!

Si queremos Per Project Installation
Ver https://laravel.com/docs/9.x/homestead#per-project-installation

Para crear una Aplicación Laravel, entrar a la caja
- vagrant ssh

Crear nueva laravel app
- cd code
- laravel new test --jet

## Para Config site en /etc/hosts:
- sudo micro /etc/hosts
```php
127.0.0.1	localhost
127.0.1.1	latitude

# homestead
192.168.56.56  homestead.test
192.168.56.56  homestead.pruebas.livewire
```

## Si le hacemos algún cambio a /etc/hosts podemos hacer reload con:
- sudo service network-manager restart
- vagrant provision

## Si le hacemos algún cambio al yml file:
- vagrant reload --provision
o
- vagrant provision

## Para salir
- exit
- vagrant halt

Listo!

## How to Setup a Laravel Project You Cloned from Github.com
Clonar el git master y descomprimirlo

Todos los comandos desde la caja de Homestead e ir al proyecto
- vagrant ssh

Para crear vendor dir
- composer install

Para crear node_modules dir
- npm install

Creare a copy of your .env file

Generate an app encryption key
- php artisan key:generate

Create an empty database sqlite en database/
- database.sqlite

In the .env file, add database information to allow Laravel to connect to the database
- .env

https://laravel.com/docs/9.x/homestead#connecting-to-databases
Si estamos usando database de mysql
```php
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=test    (nombre que le dimos a la base de datos en homestead.yaml)
DB_USERNAME=homestead
DB_PASSWORD=secret
```

Storage Link
- php artisan storage:link

Migrate the database
- php artisan migrate
[Optional]: Seed the database
- php artisan migrate:fresh --seed

Compilar:
- npm run dev
o
- npm run watch
# A Partir de aquí es la documentación Vieja!
# LaravelHomeStead - VagrantBox
# How to install Homestead, in 8 minutes - Set up Laravel Homestead tutorial 1
https://www.youtube.com/watch?v=b3HLNJvVzNo&list=PL41lfR-6DnOqzgYCAOIBTnMUFNdLtsKuW&index=1
vagrant --version
## Instalar vagrant box on computer
> vagrant box add laravel/homestead
a la fecha se esta instalando la version V11.3.0
## para listar las boxes que tengo instaladas
> vagrant box list
## clone git en:
git clone https://github.com/laravel/homestead.git ~/laravel-projects/Homestead
## init
cd laravel-projects/Homestead
bash init.sh
## examinar homestead.yml
generar los ssh keys
> ssh-keygen -t rsa -C "you@homestead"
default location is fine!
No las genere porque yo ya tengo un par

crear carpeta code dentro de laravel-projects

volver a ir a Homestead
correr:
vagrant up
vagrant ssh

$ vagrant ssh
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-73-generic x86_64)

 _                               _                 _ 
| |                             | |               | |
| |__   ___  _ __ ___   ___  ___| |_ ___  __ _  __| |
| '_ \ / _ \| '_ ` _ \ / _ \/ __| __/ _ \/ _` |/ _` |
| | | | (_) | | | | | |  __/\__ \ ||  __/ (_| | (_| |
|_| |_|\___/|_| |_| |_|\___||___/\__\___|\__,_|\__,_|

* Homestead v12.3.1 | Thanks for using Homestead
* Settler v11.3.0


vagrant@homestead:~$ ls
code
vagrant@homestead:~$ php --version
PHP 8.0.5 (cli) (built: May  3 2021 11:30:57) ( NTS )
Copyright (c) The PHP Group
Zend Engine v4.0.5, Copyright (c) Zend Technologies
    with Zend OPcache v8.0.5, Copyright (c), by Zend Technologies
vagrant@homestead:~$ mysql --version
mysql  Ver 8.0.25-0ubuntu0.20.04.1 for Linux on x86_64 ((Ubuntu))
vagrant@homestead:~$ composer --version
Composer version 2.1.5 2021-07-23 10:35:47
vagrant@homestead:~$ 

ls
cd code
vagrant@homestead:~$ composer global require laravel/installer

Craer nuevo proyecto:
laravel new primer-proyecto-homestead

Ya si nos vamos a:
~/laravel-projects/code/primer-proyecto-homestead
aqui tenemos el proyecto local que esta mapiado al vagarnt box

porque el vagrant up ya esta corriendo.
para ver la pagina podemos ya visitar:
http://localhost:8000/

Para poder visitar primer-proyecto-homestead.test en nuestro web browser darlo de alta en: 
sudo micro /etc/hosts

127.0.0.1	localhost
127.0.1.1	latitude
192.168.33.10   vgdemo.local www.vgdemo.local

127.0.0.1   primer-proyecto-homestead.test
127.0.0.1   school.demo
# Para tener multiples proyectos
## Modificar Homestead.yml

folders:
	- map: ~/laravel-projects/code
       to: /home/vagrant/code

sites:
	- map: primer-proyecto-homestead.test
	   to: /home/vagrant/code/primer-proyecto-homestead/public
    
	- map: school.demo
	   to: /home/vagrant/code/school/public  

databases:
    
	- primer-proyecto-homestead
	- school
## Abrir nuestra homestead box

	cd /home/enrique/laravel-projects/Homestead
	> vagrant up 
	> vagrant ssh
	> cd code
	> laravel new school

	Al hacerle modificaciones al homestead.yml hay que exit del ssh y correr:
	> vagrant provision

	Para acceder a nuestro proyecto en el web browser:
	http://school.demo:8000/
## para salir
- exit
- vagrant halt
# Ejemplo  de Homestead.yaml que ya me funciono:
	---
	ip: "192.168.56.56"
	memory: 2048
	cpus: 2
	provider: virtualbox

	authorize: ~/.ssh/id_rsa.pub

	keys:
		- ~/.ssh/id_rsa

	folders:
		- map: ~/laravel/homestead
		   to: /home/vagrant/code

	sites:
		- map: homestead.test1
		   to: /home/vagrant/code/test1/public

		- map: homestead.poslite
		   to: /home/vagrant/code/poslite/public

	databases:
		- test1
		- poslite

	features:
		- mysql: true
		- mariadb: false
		- postgresql: false
		- ohmyzsh: false
		- webdriver: false

	services:
		- enabled:
			- "mysql"
	#    - disabled:
	#        - "postgresql@11-main"

	#ports:
	#    - send: 33060 # MySQL/MariaDB
	#      to: 3306
	#    - send: 4040
	#      to: 4040
	#    - send: 54320 # PostgreSQL
	#      to: 5432
	#    - send: 8025 # Mailhog
	#      to: 8025
	#    - send: 9600
	#      to: 9600
	#    - send: 27017
	#      to: 27017
# Ejemplo de /etc/hosts que ya me funciono:

	127.0.0.1	localhost
	127.0.1.1	latitude

	# The following lines are desirable for IPv6 capable hosts
	::1     ip6-localhost ip6-loopback
	fe00::0 ip6-localnet
	ff00::0 ip6-mcastprefix
	ff02::1 ip6-allnodes
	ff02::2 ip6-allrouters

	# homestead
	192.168.56.56  homestead.test1
	192.168.56.56  homestead.poslite
# Reload etc/hosts
	
	sudo service network-manager restart

	Mas info en:
	https://linuxhint.com/reload-edited-etchosts-linux/
# Listo con esto ya puedo manejar multiples proyectos de laravel

Si le hacemos algún cambio al yml file:
```php
> vagrant reload --provision
```
# What is the proper way to remove/delete a project in Homestead
https://laracasts.com/discuss/channels/general-discussion/what-is-the-proper-way-to-removedelete-a-project-in-homestead

What I do is remove them from the Homestead.yaml file, remove the databases I used for testing and also removed the folder I have on my local computer. Homestead will sync that too, so they are removed from your virtual machine as well ;)
# Ejemplo de /etc/host
```php
127.0.0.1	localhost
127.0.1.1	latitude

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

# homestead
192.168.56.56  homestead.poslite
192.168.56.56  homestead.dominalaravel
192.168.56.56  homestead.livewire
192.168.56.56  homestead.inventory
192.168.56.56  homestead.restapi
192.168.56.56  homestead.l7inventory
192.168.56.56  homestead.school
```


