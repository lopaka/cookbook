#--------------------
# default recipe will download monogodb into /tmp dir
#--------------------

tarball = "#{node[:db_mongodb][:tarball]}"

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

