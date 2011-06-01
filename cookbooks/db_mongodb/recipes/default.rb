#--------------------
# default recipe will download monogodb into /tmp dirk
# install mongodb to /usr/local/bin
# and create needed dirs and init scripts
#--------------------

tarball     = "#{node[:db_mongodb][:tarball]}"
content_dir = "#{node[:db_mongodb][:content_dir]}"
data_dir    = "#{node[:db_mongodb][:data_dir]}"
conf_file   = "#{node[:db_mongodb][:conf_file]}"
log_file    = "#{node[:db_mongodb][:log_file]}"

execute "wget" do
    cwd "/tmp"
    command "wget -q http://fastdl.mongodb.org/linux/#{tarball}"
    creates "/tmp/#{tarball}"
    action :run
end

#--------------------
# untar tarball
#--------------------

execute "tar" do
    cwd "/tmp"
    command "tar xzf /tmp/#{tarball}"
    action :run
end


#--------------------
# create user:group mongo:mongo
#--------------------

group "mongo" do
    gid 1000
end

user "mongo" do
    comment "MongoDB user"
    uid "1000"
    gid "mongo"
    home "/home/mongo"
    shell "/bin/sh"
end    


#--------------------
# copy content of bin
#--------------------

execute "cp" do
    cwd "/tmp"
    command "cp #{content_dir}/bin/* /usr/local/bin/"
    action :run
end


#--------------------
# create data dir
#--------------------

directory "#{data_dir}" do
    owner "mongo"
    group "mongo"
    mode "0700"
    recursive true
    action :create
end


#--------------------
# create log file since running as 'mongo' will not allow
# creation of file on centos in /var/log
#--------------------

file "#{log_file}" do
    owner "mongo"
    group "mongo"
    mode "0755"
    action :create
end


#--------------------
# create simple conf file if it does not already exists
#--------------------

file "#{conf_file}" do
    owner "mongo"
    group "mongo"
    mode "0755"
    content "# #{conf_file} file\n"
    not_if {File.exists?("#{conf_file}")}
    action :create
end


#--------------------
# create start up script
#--------------------

template "/etc/init.d/mongod" do
    source "init-mongod.erb"
    mode 0755
    owner "root"
    group "root"
    variables(
        :data_dir => "#{data_dir}",
        :conf_file => "#{conf_file}",
        :log_file => "#{log_file}"
    )
    action :create_if_missing
end


#--------------------
# start the service
#--------------------

service "mongod" do
    action [ :enable, :start ]
end
