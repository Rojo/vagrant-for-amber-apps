#!/usr/bin/env bash

###
# Update system packages
system_update() {
  echo "Updating box software ************************************************ "
  sudo apt-get update && sudo apt-get upgrade -y
  sudo apt-get install -y tree
}

###
# Set vagrant user settings
user_conf(){
  echo "Setting vagrant user configuration *********************************** "
  # Generate language files
  sudo locale-gen en_US.UTF-8
  sudo update-locale LANG=en_US.UTF-8

  # Set language with env variables
  echo -e '\n# Set locale configuration' >> ~/.profile
  echo 'export LC_ALL=en_US.UTF-8' >> ~/.profile
  echo 'export LANG=en_US.UTF-8' >> ~/.profile
  echo -e 'export LANGUAGE=en_US.UTF-8\n' >> ~/.profile

  # Move to the sync folder at login
  echo -e '\n# Move to /vagrant at log in' >> ~/.profile
  echo -e 'cd /vagrant\n' >> ~/.profile
}

###
# Install and configure PostgreSQL database manager
install_postgres() {
  echo "Installing PostgreSQL database manager ******************************* "
  sudo apt-get install -y postgresql postgresql-contrib

  echo "Setting up user"
  sudo -u postgres bash -c "psql -c \"CREATE USER vagrant WITH PASSWORD 'vagrant';\""
  sudo -u postgres bash -c "psql -c \"ALTER USER vagrant WITH SUPERUSER;\""

  echo "Setting up extensions to all schemas"
  sudo -u postgres bash -c "psql -c \"CREATE EXTENSION unaccent SCHEMA pg_catalog;\""
  sudo -u postgres bash -c "psql -c \"CREATE EXTENSION pg_trgm SCHEMA pg_catalog;\""

  echo " Starting Postgres server "
  sudo service postgresql start
}

###
# Install Crystal compiler
install_crystal() {
  echo "Installing Crystal language compiler ********************************* "
  sudo apt-get install -y gdebi

  curl -L https://github.com/crystal-lang/crystal/releases/download/0.26.1/crystal_0.26.1-1_amd64.deb > crystal.deb
  sudo gdebi -n crystal.deb
}

###
# Install Amber framework
install_amber() {
  echo "Installing Amber framework ******************************************* "
  sudo apt-get install -y libreadline-dev \
    libsqlite3-dev \
    libpq-dev \
    libmysqlclient-dev \
    libssl-dev \
    libyaml-dev

  sudo apt build-dep -y nginx

  mkdir amber-framework
  curl -L https://github.com/amberframework/amber/archive/v0.9.0.tar.gz | tar xz -C amber-framework --strip-components 1
  cd amber-framework/
  shards install
  sudo make install
  sudo chown vagrant:vagrant -R ~/.cache/
}

###
# Install Node Version Manager
install_nvm() {
  echo "Installing NVM ******************************************************* "
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

  echo -e "\n# Node Version Manager" >> ~/.profile
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.profile
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.profile
  echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.profile
  echo -e "\n" >>  ~/.profile

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

###
# Install stable version of Node.js
install_nodejs() {
  echo 'Installing Node.js *************************************************** '
  nvm install stable
  nvm alias default stable
  nvm use default
}

###
# Remove unused files
cleanup() {
  echo "Removing unused files ************************************************ "
  cd ..
  rm crystal.deb
  rm -rf amber-framework
  sudo apt-get -y autoremove && sudo apt-get autoclean
}

###
# Main function
setup(){
  system_update
  user_conf
  install_postgres
  install_crystal
  install_amber
  install_nvm
  install_nodejs
  cleanup
}

setup "$@"
