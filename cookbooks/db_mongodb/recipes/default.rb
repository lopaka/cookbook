tarball = "mongodb-linux-i686-1.8.1.tgz"

remote_file "/tmp/#{tarball}" do
    source "http://fastdl.mongodb.org/linux/#{tarball}"
    mode "0644"
end

execute "tar" do
    cwd "/tmp"
    command "tar xzf /tmp/#{tarball}"
    action :run
end


