#--------------------
# install_mongodb recipe will install mongodb to /usr/local/bin
#--------------------

content_dir = "/tmp/mongodb-linux-i686-1.8.1"
`cp #{content_dir}/bin/* /usr/local/bin/`
`rm -rf #{content_dir}`

