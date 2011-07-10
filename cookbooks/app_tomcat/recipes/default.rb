# Cookbook Name:: app_tomcat
# Recipe:: default

# == Install user-specified Packages and Modules
#
#[ node[:tomcat][:package_dependencies] | node[:tomcat][:modules_list] ].flatten.each do |p|
#  package p
#end
#
#node[:tomcat][:module_dependencies].each do |mod|
#  apache_module mod
#end

# TEST - currently only for centos
case platform
when "centos","fedora","suse"
  package "eclipse-ecj" do
    action:install
  end
  
  # ln -s /usr/share/java/eclipse-ecj.jar /usr/share/java/ecj.jar
  link "/usr/share/java/ecj.jar" do
    to "/usr/share/java/eclipse-ecj.jar"
  end
  
  [ "tomcat6","tomcat6-admin-webapps","tomcat6-webapps","tomcat-native","mysql-connector-java" ].each do |p|
    log "installing #{p}"
    package p
  end
  
  execute "alternatives" do
    command "alternatives --auto java"
    action :run
  end
  
  ## Link mysql-connector plugin to Tomcat6 lib
  # ln -sf /usr/share/java/mysql-connector-java.jar /usr/share/tomcat6/lib/mysql-connector-java.jar
  link "/usr/share/tomcat6/lib/mysql-connector-java.jar" do
    to "/usr/share/java/mysql-connector-java.jar"
  end
else
  set[:db_mysql][:socket] = "/var/run/mysqld/mysqld.sock"
end
