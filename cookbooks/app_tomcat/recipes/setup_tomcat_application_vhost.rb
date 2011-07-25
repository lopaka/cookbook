# Cookbook Name:: app_tomcat
# Recipe:: setup_tomcat_application_vhost

service "apache2" do
  action :nothing
end

# disable default vhost
apache_site "000-default" do
  enable false
end

node[:apache][:listen_ports] << "8000" unless node[:apache][:listen_ports].include?("8000")

template "#{node[:apache][:dir]}/ports.conf" do
  cookbook "apache2"
  source "ports.conf.erb"
  variables :apache_listen_ports => node[:apache][:listen_ports]
  notifies :restart, resources(:service => "apache2")
end

# == Configure apache vhost for Tomcat
#
#web_app node[:tomcat][:application_name] do
web_app node[:web_apache][:application_name] do
  template "apache.conf.erb"
  docroot node[:web_apache][:docroot]
  vhost_port "8000"
  server_name node[:tomcat][:server_name]
  cookbook "web_apache"
  notifies :restart, resources(:service => "apache2")
end
