# Cookbook Name:: app_tomcat
# Recipe:: setup_db_connection

# == Setup tomcat Database Connection
#

template "/etc/tomcat6/context.xml" do
  source "context_xml.erb"
  owner
  group
  mode "0644"
  variables(
    :user      => node[:db_mysql][:application][:user],
    :ipassword => node[:db_mysql][:application][:password],
    :fqdn      => node[:db_mysql][:fqdn],
    :database  => node[:app_tomcat][:db_name]
  )
end

