#--------------------
# default recipe will download and untar monogodb into /tmp dir
#--------------------

tarball = "mongodb-linux-i686-1.8.1.tgz"

cookbook_file "/tmp/#{tarball}" do
    backup false
    source "#{tarball}"
end

execute "tar" do
    cwd "/tmp"
    command "tar xzf /tmp/#{tarball}"
    action :run
end


