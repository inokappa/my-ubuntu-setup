#
# Cookbook Name:: my-ubuntu-setup
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#
execute "apt-get update" do
  command "apt-get update"
end
#
%w{gnome-do xfce4 xfce4-battery-plugin xfce4-systemload-plugin}.each do |base|
  package base do
    action :install
  end
end
#
%w{ibus-mozc mozc-server mozc-utils-gui vim tmux ruby1.9.1 ruby1.9.1-dev vagrant virtualbox git subversion lxc tree wine g2ipmsg}.each do |app|
  package base do
    action :install
  end
end
#
bash "setup other app's repos" do
  user "root"
  cwd "/tmp"
  code << EOH
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    wget -qO- https://get.docker.io/gpg | apt-key add -
    sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
    add-apt-repository ppa:shutter/ppa
    apt-get update
  EOH
end

%w{google-chrome-stable lxc-docker shutter}.each do |other_pkg|
  package other_pkg do
    action :install
  end
end

#
package "xsel" do
  action :install
end

cookbook_file "/home/user/.tmux.conf" do
  source "tmux.conf.default"
  mode 00644
  owner user
  group group
  action :create
end
