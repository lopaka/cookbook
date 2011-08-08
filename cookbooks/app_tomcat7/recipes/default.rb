# Cookbook Name:: app_tomcat7
# Recipe:: default

# TODO - changes if not centos (ie ubuntu)
# TEST - currently only for centos
case node[:platform]
when "centos","fedora","suse"

# for tomcat7
# - currently, jre and tomcat binaries are in 'files' attached to recipe
# - remove any jre or jde installed - on base die "yum erase jdk.x86_64"
# - rpm -ihv ./jre-7-linux-x64.rpm
#   this insalled jre-7 in /usr/java/jre1.7.0 - look into /usr/share/java?
# - set JRE_HOME env to /usr/java/jre1.7.0 ( or where jre-7 is installed)
#   JRE_HOME=/usr/java/jre1.7.0 && export JRE_HOME
# - unpack apache-tomcat-7.0.19.tar.gz in /usr/share/tomcat7
#   cd /usr/share && tar xzvf ~/apache-tomcat-7.0.19.tar.gz && mv apache-tomcat-7.0.19 tomcat7
#   $CATALINA_HOME is now /usr/share/tomcat7
# - edit server.xml for port 8080
# - startup and shutdown scripts at /usr/share/tomcat7/bin/startup.sh, shutdown.sh - look into putting
#   into /etc/init.d and chkconfig


####  node[:tomcat][:package_dependencies].each do |p|
####    log "installing #{p}"
####    package p
####
####    # eclipse-ecj and symlink must be installed FIRST
####    if p=="eclipse-ecj"
####      # ln -sf /usr/share/java/eclipse-ecj.jar /usr/share/java/ecj.jar
####      # todo: if /usr/share/java/ecj.jar exists delete first
####      link "/usr/share/java/ecj.jar" do
####        to "/usr/share/java/eclipse-ecj.jar"
####      end
####    end
####  end
####
####  execute "alternatives" do
####    command "alternatives --auto java"
####    action :run
####  end
####  
####  ## Link mysql-connector plugin to Tomcat6 lib
####  # ln -sf /usr/share/java/mysql-connector-java.jar /usr/share/tomcat6/lib/mysql-connector-java.jar
####  # todo: if /usr/share/tomcat6/lib/mysql-connector-java.jar exists delete it first
####  link "/usr/share/tomcat6/lib/mysql-connector-java.jar" do
####    to "/usr/share/java/mysql-connector-java.jar"
####  end
####
####  ## "Linking RightImage JAVA_HOME to what Tomcat6 expects to be..."
####  # ln -nfs $java_home $tc_java_home
####  # ln -nfs /usr/java/default /usr/lib/jvm/java
####  link "/usr/lib/jvm/java" do
####    to "/usr/java/default"
####  end
####
####
####  # Moving tomcat logs to mnt
####  if ! File.directory?("/mnt/log/tomcat6") 
####    directory "/mnt/log/tomcat6" do
####      owner "tomcat"
####      group "tomcat"
####      mode "0755"
####      action :create
####      recursive true
####    end
####    directory "/var/log/tomcat6" do
####      action :delete
####      recursive true
####    end
####    link "/var/log/tomcat6" do
####      to "/mnt/log/tomcat6"
####    end
####  end


else
    log "nothing done yet for non centos"
end
