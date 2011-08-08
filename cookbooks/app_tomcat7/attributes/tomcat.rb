# == Recommended attributes
#
set_unless[:tomcat7][:server_name] = "myserver"  
set_unless[:tomcat7][:application_name] = "myapp"

# == Optional attributes
#
set_unless[:tomcat7][:code][:url] = ""
set_unless[:tomcat7][:code][:credentials] = ""
set_unless[:tomcat7][:code][:branch] = "master"  
set_unless[:tomcat7][:db_adapter] = "mysql"

# == Calculated attributes
#

case platform
when "ubuntu", "debian"
  set[:db_mysql][:socket] = "/var/run/mysqld/mysqld.sock"
when "centos","fedora","suse"
  #"mod_jk-ap20"
#  set[:tomcat7][:package_dependencies] = ["eclipse-ecj",\
#                                         "tomcat6",\
#                                         "tomcat6-admin-webapps",\
#                                         "tomcat6-webapps",\
#                                         "tomcat-native",\
#                                         "mysql-connector-java"]
#  set[:tomcat][:module_dependencies] = [ "proxy", "proxy_http", "jk" ]
  set[:tomcat7][:module_dependencies] = [ "proxy", "proxy_http" ]
  set_unless[:tomcat7][:app_user] = "tomcat"
  set[:db_mysql][:socket] = "/var/lib/mysql/mysql.sock"
end
