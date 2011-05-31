remote_file "/tmp/mongodb-linux-i686-1.8.1.tgz" do
    source "http://fastdl.mongodb.org/linux/mongodb-linux-i686-1.8.1.tgz"
    mode "0644"
end

execute "tar" do
    cwd /tmp
    command "tar xzf /tmp/mongodb-linux-i686-1.8.1.tgz"
    action :run
end


