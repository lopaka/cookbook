#--------------------
# default recipe will download and untar monogodb into /tmp dir
#--------------------

tarball = "mongodb-linux-i686-1.8.1.tgz"

cookbook_file "/tmp/#{tarball}"
    backup false
    source "#{tarball}
end

#execute "wget" do
#    cwd "/tmp"
#    command "wget -q http://fastdl.mongodb.org/linux/#{tarball}"
#    creates "/tmp/#{tarball}"
#    action :run
#end


execute "tar" do
    cwd "/tmp"
    command "tar xzf /tmp/#{tarball}"
    action :run
end


