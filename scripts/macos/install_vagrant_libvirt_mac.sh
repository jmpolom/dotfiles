#!/bin/zsh

set -eux

CONFIGURE_ARGS='with-ldflags=-L/opt/vagrant/embedded/lib \
                with-libvirt-include=/usr/local/include \
                with-libvirt-lib=/usr/local/lib' \
GEM_HOME=~/.vagrant.d/gems \
GEM_PATH=$GEM_HOME:/opt/vagrant/embedded/gems \
PATH=/opt/vagrant/embedded/bin:$PATH \
vagrant plugin install vagrant-libvirt
