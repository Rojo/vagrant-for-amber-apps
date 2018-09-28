# Amber Virtual Development Environment on Vagrant


[Español][es] |
------------- |

Configuration files to automatically set up a basic and customizable Vagrant box with the required tools to develop Amber projects.

## Usage

1. Install in your computer the software listed in the "Prerequisites" section.
2. Clone the repository into your machine.
3. Tweak the provider and the options in the `Vagrantfile`.
4. Run `vagrant up` and wait for the machine to be built, then `vagrant reload`.
5. When the machine is ready, run `vagrant ssh` and move to the synced folder with `cd /vagrant`.
6. You may now start a new Amber project or install the shards of your current project.

## Prerequisites

* [Vagrant][0]
* [Virtualbox][1] and the extension pack.

If you notice that there are delays with the synchronization of shared folders with `virtualbox` as the `type`, a better option is to use [SSHFS][2] or [NFS][3]. But it usually works well enough.

## Out of the Box Included Software

* **[Ubuntu Bionic][4]**: Latest version of this popular Linux distribution.

* **[Crystal][5] 0.26.1**: Programming language that performs close to C with a programmer friendly Ruby-like syntax.

* **[Amber][6] 0.9.0**: Web framework that aims to build REALLY fast web applications while keeping things simple and enjoyable.

* **[Node.js][7]**: Server side JavaScript runtime. (Current stable version).

* **[Postgres][8]**: Advanced SQL database. (Current Bionic distribution).
  - User: `vagrant`
  - Pass: `vagrant`


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
[es]: lang/README.es.md
