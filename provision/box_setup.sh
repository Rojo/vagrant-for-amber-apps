#!/usr/bin/env bash

update() {
  echo "Updating box software"
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y tree
}

# Language configuration
lang_conf(){
  echo -e "\n# Set locale configuration" >> ~/.bashrc
  echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc
  echo "export LANG=en_US.UTF-8" >> ~/.bashrc
  echo -e "export LANGUAGE=en_US.UTF-8\n" >> ~/.bashrc
}

# Postgres installation
postgres() {
  echo "Installing PostgreSQL database manager"
  sudo apt update
  sudo apt install -y postgresql postgresql-contrib

  echo "Setting up user"
  sudo -u postgres bash -c "psql -c \"CREATE USER ubuntu WITH PASSWORD 'ubuntu';\""
  sudo -u postgres bash -c "psql -c \"ALTER USER ubuntu WITH SUPERUSER;\""

  echo "Setting up extensions to all schemas"
  sudo -u postgres bash -c "psql -c \"CREATE EXTENSION unaccent SCHEMA pg_catalog;\""
  sudo -u postgres bash -c "psql -c \"CREATE EXTENSION pg_trgm SCHEMA pg_catalog;\""

  echo " Starting Postgres server "
  sudo service postgresql start
}

crystal() {
  echo "Installing Crystal language compiler"
  curl https://dist.crystal-lang.org/apt/setup.sh | sudo bash
  sudo apt install -y build-essential crystal
}

amber() {
  echo "Installing Amber framework"
  sudo apt install -y libreadline-dev \
    libsqlite3-dev \
    libpq-dev \
    libmysqlclient-dev \
    libssl-dev \
    libyaml-dev

  sudo apt build-dep -y nginx

  curl -L https://github.com/amberframework/amber/archive/stable.tar.gz | tar xz
  cd amber-stable/
  shards install
  sudo make install
}

cleanup() {
  cd $HOME
  rm -rf amber-stable
  sudo apt -y autoremove && sudo apt autoclean
}

setup(){
  update
  lang_conf
  postgres
  crystal
  amber
  cleanup
}

setup "$@"
