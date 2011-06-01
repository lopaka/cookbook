#--------------------
# clean /tmp
#--------------------

content_dir = "#{node[:db_mongodb][:content_dir]}"
tarball = "#{node[:db_mongodb][:tarball]}"



#--------------------
# remove content_dir
#--------------------

directory "#{content_dir}" do
    recursive true
    action :delete
end


#--------------------
# remove tarball
#--------------------

file "/tmp/#{tarball}" do
    action :delete
end
