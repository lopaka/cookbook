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
case node[:platform]
when "centos","fedora","suse"

  node[:tomcat][:package_dependencies].each do |p|
    log "installing #{p}"
    package p

    # eclipse-ecj and symlink must be installed FIRST
    if p=="eclipse-ecj"
      # ln -sf /usr/share/java/eclipse-ecj.jar /usr/share/java/ecj.jar
      # todo: if /usr/share/java/ecj.jar exists delete first
      link "/usr/share/java/ecj.jar" do
        to "/usr/share/java/eclipse-ecj.jar"
      end
    end

  end

  execute "alternatives" do
    command "alternatives --auto java"
    action :run
  end
  
  ## Link mysql-connector plugin to Tomcat6 lib
  # ln -sf /usr/share/java/mysql-connector-java.jar /usr/share/tomcat6/lib/mysql-connector-java.jar
  # todo: if /usr/share/tomcat6/lib/mysql-connector-java.jar exists delete it first
  link "/usr/share/tomcat6/lib/mysql-connector-java.jar" do
    to "/usr/share/java/mysql-connector-java.jar"
  end


  # Moving tomcat logs to mnt
  if ! File.directory?("/mnt/log/tomcat6") 
    directory "/mnt/log/tomcat6" do
      owner "tomcat"
      group "tomcat"
      mode "0755"
      action :create
      recursive true
    end
    directory "/var/log/tomcat6" do
      action :delete
      recursive true
    end
    link "/var/log/tomcat6" do
      to "/mnt/log/tomcat6"
    end
  end
else
    log "nothing done yet for non centos"
end
