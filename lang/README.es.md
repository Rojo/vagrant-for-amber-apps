
# Entorno virtual de desarollo para Amber en Vagrant

[English][en] |
------------- |

Archivos de configuración para construir automaticamente una maquina virtual flexible con las herramientas básicas para desarrollar proyectos con el framework Amber.


## Forma de uso

1. Instala en tu computadora el software listado en la sección «Prerequisitos».
2. Clona el repositorio en tu computadora.
3. Ajusta el parametro `provider` y otras opciones del `Vagrantfile`.
4. Ejecuta `vagrant up` y espera a que la maquina virtual se construya. Al terminar, ejecuta `vagrant reload`.
5. Ya con la maquina virtual lista, conectate a ella con `vagrant ssh` y muevente al directorio sincronizado con `cd /vagrant`.
6. Ahora puedes crear un projecto de nuevo de Amber o instalar los _shards_ de tu proyecto existente.


## Prerequisitos

* [Vagrant][0]
* [Virtualbox][1] y el paquete de extensión.

Si experimentas retrasos en la sincronización de archivos con `virtualbox` como `type`, una mejor opcion es usar [SSHFS][2] o [NFS][3], aunque usualmente funciona bien.


## Software incluido

* **[Ubuntu Bionic][4]**: Version más reciente de ésa popular distribución de Linux.

* **[Crystal][5] 0.26.1**: Lenguaje de programación con un desempeño parecido a _C_ y una sintaxis parecida a Ruby, amigable con el programador.

* **[Amber][6] 0.9.0**: Framework web que apunta a construir aplicaciones REALMENTE rápidas al tiempo que mantiene las cosas simples y disfrutables.

* **[Node.js][7]**: Motor de ejecición para JavaScript del lado del servidor. (Versión estable más reciente).

* **[Postgres][8]**: Manejador avanzado de bases de datos relacionales. (Distribución de Bionic).
  - Usuario: `vagrant`
  - Contraseña: `vagrant`

---
[0]: https://www.vagrantup.com/downloads.html
[1]: https://www.virtualbox.org/wiki/Downloads
[2]: https://fedoramagazine.org/vagrant-sharing-folders-vagrant-sshfs/
[3]: https://www.vagrantup.com/docs/synced-folders/nfs.html
[4]: https://app.vagrantup.com/ubuntu/boxes/bionic64
[5]: https://crystal-lang.org/
[6]: https://amberframework.org/
[7]: https://nodejs.org/en/
[8]: https://www.postgresql.org/
[en]: ../README.md
