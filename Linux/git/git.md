# Path Relativo
Linux/git/git.md

# 13-ABR-21 (Martes)

## Configuracion de Git Local
> git config --global user.name "enriquesousa"
> git config --global user.email "enrique.sousa@gmail.com"
> git config --list

## Si queremos que nos recuerde nuestras credenciales user y password por 8 Hr
> git config --global url."https://enriquesousa@github.com".username enriquesousa
> git config --global credential.helper "cache --timeout:28800"

## Conectarnos con SSH mejor!
https://www.youtube.com/watch?v=mskIcsJFzcI
Editar: **example-app/.git/config**
y sustituir el https link por el que nos da github bajo clone ssh boton en webpage de github
git@github.com:enriquesousa/example-app.git
para actualizarlo via comando CLI:
> git config remote.origin.url git@github.com:enriquesousa/example-app.git

Ya con esto podemos hacer:
> git pull origin master
> git push origin master

Y no nos pedirar user ni passsword!



## Agregue SSH Key GitHub, con los siguientes pasos:
-----------------------------------------------------
https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

> ssh-keygen -t ed25519 -C "enrique.sousa@gmail.com"
Enter a file in which to save the key (/home/you/.ssh/id_ed25519): [Press enter]
Enter passphrase (empty for no passphrase): [Type a passphrase]
Enter same passphrase again: [Type passphrase again]

$ eval "$(ssh-agent -s)"
> Agent pid 59566

Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_ed25519 in the command with the name of your private key file.

```bash
    > ssh-add ~/.ssh/id_ed25519
```

Add the SSH key to your account on GitHub. For more information, see "Adding a new SSH key to your GitHub account."

Copy the SSH public key to your clipboard.

If your SSH public key file has a different name than the example code, modify the filename to match your current setup. When copying your key, don't add any newlines or whitespace.
```bash
$ cat ~/.ssh/id_ed25519.pub
```
# Then select and copy the contents of the id_ed25519.pub file
# displayed in the terminal to your clipboard
Tip: Alternatively, you can locate the hidden .ssh folder, open the file in your favorite text editor, and copy it to your clipboard.

In the upper-right corner of any page of github, click your profile photo, then click Settings. goto ssh and GPG keys



Verificar que estamos conectados:
Testing your SSH connection
https://docs.github.com/en/github/authenticating-to-github/testing-your-ssh-connection

> sudo ssh -T git@github.com

Colocarnos en carpeta donde ya inicializamos con:
> git init

Para Fetch branches and/or tags (collectively, "refs") from repositorie
> git fetch

Para desplegar nombre del repositorio
> git remote get-url origin
https://github.com/enriquesousa/Return-App.git

Si queremos colocarnos/cambiarnos a un repo
> git remote set-url origin https://github.com/enriquesousa/Return-App.git
# Crear un Repositorio en gitHub
# Push an existing repository from the command line
----------------------------------------------------

> git remote add origin https://github.com/enriquesousa/example-app.git
> git branch -M main
> git push -u origin main
# Corey Schafer
# Git Tutorial for Beginners: Command-Line Fundamentals
## https://www.youtube.com/watch?v=HVsySz-h9r4
## -------------------------------------------------------

## CHECK VERSION
> git --version
git version 2.31.1


## SET CONFIG VALUES
> git config --global user.name "enriquesousa"
> git config --global user.email "enrique.sousa@gmail.com"
> git config --list

## NEED HELP
> git help <verb>
> git <verb> help

## INITIALIZE A REPOSITORY FROM LOCAL EXISTING CODE
> git init

## BEFORE FIRST COMMIT
> git status

## ADD FILES TO STAGING AREA
> git add -A
> git status

## REMOVE FILES FROM STAGING AREA
> git reset
> git status

## OUR FIRST COMMIT
> git add -A
> git commit -m "initial commit"
> git status
> git log

## CLONNING A REMOTE REPO
> git clone <url> <where to clone>
> git clone https://github.com/enriquesousa/example-app.git .

## VIEWING INFORMATION ABOUT THE REMOTE REPOSITORY
> git remote -v
> git branch -a

## PUSHING CHANGES
------------------
## COMMIT CHANGES
> git diff
> git status
> git add -A
> git commit -m "Modifiqe tal archivo"

## THEN PUSH
> git pull origin master
> git push origin master


## Conectarnos con SSH mejor!
https://www.youtube.com/watch?v=mskIcsJFzcI
Editar: **example-app/.git/config**
y sustituir el https link por el que nos da github bajo clone ssh boton en webpage de github
git@github.com:enriquesousa/example-app.git
para actualizarlo via comando CLI:
> git config remote.origin.url git@github.com:enriquesousa/example-app.git

para proyecto return-app:
> git config remote.origin.url git@github.com:enriquesousa/Return-App.git

Ya con esto podemos hacer:
> git pull origin master
> git push origin master

Y no nos pedira user ni passsword!
# SUBLIME TEXT GITSAVVY
------------------------
Teniendo mi coneccion SSH ya puedo usar mas comodo el
workflo de gitsavvy en sublime text3 con

ctrl+shift+p        git: init
ctrl+shift+p        git: status
ctrl+shift+p        git: remote add


--------------------------------------------------
# Primeros pasos para subir un nuevo repositorio
--------------------------------------------------
1. crear el repositorio y luego subirlo con hacer:
2. > git init
en la carpeta que vamos a versionar.
Si estoy usando Homestead, usar todos los comandos desde la carpeta local No la remota que esta en la maquina virtual de homestead.

## Add origin via
### repositorios creados
    > git remote add origin git@github.com:enriquesousa/multiau.git
    > git remote add origin git@github.com:enriquesousa/multiauth.git
    > git remote add origin git@github.com:enriquesousa/basic-multiauth-jetstream.git
    > git remote add origin git@github.com:enriquesousa/crud-products.git
    > git remote add origin git@github.com:enriquesousa/ex1.git
    > git remote add origin git@github.com:enriquesousa/Products.git
    > git remote add origin git@github.com:enriquesousa/TALL.git
    > git remote add origin git@github.com:enriquesousa/poslite.git
    > git remote add origin git@github.com:enriquesousa/homestead-dominalaravel.git
    > git remote add origin git@github.com:enriquesousa/livewire.git
    > git remote add origin git@github.com:enriquesousa/inventory.git
    > git remote add origin git@github.com:enriquesousa/restapi.git
### El ultimo    
    > git remote add origin git@github.com:enriquesousa/l7inventory.git
    > git remote add origin git@github.com:enriquesousa/inventory_lando.git
    > git remote add origin git@github.com:enriquesousa/school.git
    > git remote add origin git@github.com:enriquesousa/blog.git
    > git@github.com:enriquesousa/livewire-lando.git

## Crear main branch (opcional) por omision es Master
### Si no pongo esta linea el branch queda en Master 
    > git branch -M main (NO CREARLO)

## Activar Conexión SSH
### Conexiones creadas
    > git config remote.origin.url git@github.com:enriquesousa/multiau.git
    > git config remote.origin.url git@github.com:enriquesousa/basic-multiauth-jetstream.git
    > git config remote.origin.url git@github.com:enriquesousa/multi-autenticacion-con-tema.git
    > git config remote.origin.url git@github.com:enriquesousa/crud-products.git
    > git config remote.origin.url git@github.com:enriquesousa/ex1.git
    > git config remote.origin.url git@github.com:enriquesousa/apapa.git
    > git config remote.origin.url git@github.com:enriquesousa/Products.git
    > git config remote.origin.url git@github.com:enriquesousa/TALL.git
    > git config remote.origin.url git@github.com:enriquesousa/poslite.git
    > git config remote.origin.url git@github.com:enriquesousa/DominaLaravel.git
    > git config remote.origin.url git@github.com:enriquesousa/livewire.git
    > git config remote.origin.url git@github.com:enriquesousa/inventory.git
    > git config remote.origin.url git@github.com:enriquesousa/restapi.git
### Ultima conexion
    > git config remote.origin.url git@github.com:enriquesousa/l7inventory.git
    > git config remote.origin.url git@github.com:enriquesousa/inventory_lando.git
    > git config remote.origin.url git@github.com:enriquesousa/school.git
    > git config remote.origin.url git@github.com:enriquesousa/blog.git

## Push an existing repository from the command line

git remote add origin git@github.com:enriquesousa/DominaLaravel.git
git config remote.origin.url git@github.com:enriquesousa/DominaLaravel.git
(NO) git branch -M main
(NO) git push -u origin main


## Por ultimo add and push:
> git status
> git add -A
> git commit -m "commit inicial"
> git push origin master
  o
> (NO) git push origin main

## VIEWING INFORMATION ABOUT THE REMOTE REPOSITORY
```bash
$ git remote -v
$ git branch -a
```

## Para update el local repo
- git pull origin master

Si queremos clonar, borrar el contenido del directorio inventory/ y:
- git clone git@github.com:enriquesousa/inventory_lando.git . 

Para hacer el setup de laravel con un repo recien clonado:
> composer install
> npm install
> Create a copy of your .env file desde .example.env
Generate an app encryption key
> php artisan key:generate
Create an empty database for our application
> myphpadmin (Ejemplo)
> para el caso de lando conectarse con dbeaver con el puerto que nos da lando info
In the .env file, add database information to allow Laravel to connect to the database
> .env

Migrate the database
> php artisan migrate



## How to compare a local git branch with its remote branch?
    To update remote-tracking branches, you need to type git fetch first and then :

    git diff <mainbranch_path> <remotebranch_path>
    You can git branch -a to list all branches (local and remote) then choose branch name from list (just remove remotes/ from remote branch name.

    Example: git diff main origin/main (where "main" is local main branch and "origin/main" is a remote namely origin and main branch.)

## los 10 comandos mas usados
10 Git Commands Every Developer Should Know
https://www.freecodecamp.org/news/10-important-git-commands-that-every-developer-should-know/

Clonar
- git clone git@github.com:enriquesousa/inventory_lando.git
Branch
Lista los branches que hay
- git branch --list
- git branch
Cambiarse a un Branch
- git checkout <branch-name>
- git checkot inventory_i5 
Crear un branch nuevo
- git branch <branch-name>
- git branch inventory_i5
There is also a shortcut command that allows you to create and switch to a branch at the same time:
- git checkout -b <name-of-your-branch>
To push the new branch into the remote repository:
- git push -u <remote> <branch-name>
- git push -u git@github.com:enriquesousa/inventory_lando.git inventory_i5
Deleting a branch:
- git branch -d <branch-name>
Status
- git status
To add a single file:
- git add <file>
To add everything at once:
- git add -A
Commit
- git commit -m "commit init de inventory_i5"

Push
- git push <remote> <branch-name>
However, if your branch is newly created, then you also need to upload the branch with the following command:
- git push --set-upstream <remote> <name-of-your-branch>
- git push --set-upstream git@github.com:enriquesousa/inventory_lando.git inventory_i5
or
- git push -u origin <branch_name>
- git push -u origin inventory_i5

Pull
- git pull <remote>
- git pull git@github.com:enriquesousa/inventory_lando.git

Para pull los cambios de un branch:
Primero crear el branch.
- git branch inventory_dev
Cambiarnos a el.
- git checkout inventory_dev
Fetch el branch de github.
- git fetch origin inventory_dev
Luego Merge it into the current branch.
- git merge origin/inventory_dev


Fetch all of the branches from the repository. This also downloads all of the required commits and files from the other repository.
- git fetch <remote>
- git fetch git@github.com:enriquesousa/inventory_lando.git
Same as the above command, but only fetch the specified branch.
- git fetch <remote> <branch>
- git fetch git@github.com:enriquesousa/inventory_lando.git inventory_dev

Revert
Then we just need to specify the hash code next to our commit that we would like to undo:
- git revert 3321844

Merge
When you've completed development in your branch and everything works fine, the final step is merging the branch with the parent branch (dev or master). This is done with the git merge command.
First you should switch to the dev branch:
- git checkout master
Before merging, you should update your local dev branch:
- git fetch
Finally, you can merge your feature branch into dev:
- git merge <branch-name>
- git merge inventory_i5
# git condensado
- primero crear repositorio en github
- git init
- git remote add origin git@github.com:enriquesousa/livewire_test.git
- git config remote.origin.url git@github.com:enriquesousa/livewire_test.git
- git status
- git add -A
- git commit -m "livewire_test commit inicial"
- git push origin master
# How to Setup a Laravel Project You Cloned from Github.com
Clonar el git master y descomprimirlo
Entrar a la carpeta y crear el .lando.yml:
```php
name: livewire4
recipe: laravel

config:
  php: '8.0'
  composer_version: 2-latest
  via: apache
  webroot: public
  database: mysql:8.0
  cache: redis
  xdebug: false

services:
  node:
    type: node
   
tooling:
  npm:
    service: node
```
- lando start
- lando composer install
- lando npm install
- Create a copy of your .env file

Generate an app encryption key
- lando php artisan key:generate

Create an empty database for our application
- myphpadmin (Ejemplo)

In the .env file, add database information to allow Laravel to connect to the database
- .env

Storage Link
- lando php artisan storage:link

crear nuestro propio symlink, en vez de usar php artisan storage:link del lado de la VM, correr mejor el ln del lado de la maquina local:
ln -s /location/to/link2 newlink
- ln -s /home/enrique/laravel/homestead/pruebas/livewire_test/storage/app/public storage

Para que funcione, Se tiene que correr desde VM homestead:
- php artisan storage:link

Migrate the database
- php artisan migrate
- lando php artisan migrate:fresh --seed

[Optional]: Seed the database
- php artisan db:seed

Compilar:
- lando npm run dev
- lando npm run watch


