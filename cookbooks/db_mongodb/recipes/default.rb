#--------------------
# default recipe will download and untar monogodb into /tmp dir
#--------------------

tarball = "mongodb-linux-i686-1.8.1.tgz"

# appears to be a bug in using cookbook_file in chef 0.8
# going back to wget
##### cookbook_file "/tmp/mongodb-linux-i686-1.8.1.tgz" do
#####     backup false
#####     source "mongodb-linux-i686-1.8.1.tgz"
##### end

execute "wget" do
    cwd "/tmp"
    command "wget -q http://fastdl.mongodb.org/linux/#{tarball}"
    creates "/tmp/#{tarball}"
    action :run
end


execute "tar" do
    cwd "/tmp"
    command "tar xzf /tmp/#{tarball}"
    action :run
end


