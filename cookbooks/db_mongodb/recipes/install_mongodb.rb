#--------------------
# install_mongodb recipe will install mongodb to /usr/local/bin
#--------------------

content_dir = "/tmp/mongodb-linux-i686-1.8.1"
`cp #{content_dir}/* /usr/local/bin/`
`rm -rf #{content_dir}`

