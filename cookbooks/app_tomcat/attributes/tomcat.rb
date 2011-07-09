# Cookbook Name:: app_tomcat
#
# Copyright (c) 2011 RightScale Inc
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# == Recommended attributes
#
set_unless[:tomcat][:server_name] = "myserver"  
set_unless[:tomcat][:application_name] = "myapp"

# == Optional attributes
#
set_unless[:tomcat][:db_schema_name] = ""     

set_unless[:tomcat][:code][:url] = ""
set_unless[:tomcat][:code][:credentials] = ""
set_unless[:tomcat][:code][:branch] = "master"  
set_unless[:tomcat][:modules_list] = [] 
set_unless[:tomcat][:db_adapter] = "mysql"

# == Calculated attributes
#

case platform
when "ubuntu", "debian"
  set[:tomcat][:package_dependencies] = ["sun-java6-bin","sun-java6-jre","sun-java6-jdk","eclipse","ecj-gcj","libapache2-mod-jk","libmysql-java","tomcat6","tomcat6-admin","tomcat6-user","tomcat6-examples"]
  set[:tomcat][:module_dependencies] = [ "proxy_http","mod_jk"]
  set_unless[:tomcat][:app_user] = "www-data"
  set[:db_mysql][:socket] = "/var/run/mysqld/mysqld.sock"
when "centos","fedora","suse"
  set[:tomcat][:package_dependencies] = ["sun-java6-bin","sun-java6-jre","sun-java6-jdk","eclipse-ecj","tomcat6","tomcat6-admin-webapps","tomcat6-webapps","tomcat-native","mysql-connector-java"]
  set[:tomcat][:module_dependencies] = [ "proxy", "proxy_http","mod_jk" ]
  set_unless[:tomcat][:app_user] = "apache"
  set[:db_mysql][:socket] = "/var/lib/mysql/mysql.sock"
end
