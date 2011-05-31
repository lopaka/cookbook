version=1.8.1
hardware=i686


execute "tar" do
    command "tar xzf $RS_ATTACH_DIR/mongodb-linux-${hardware}-${version}.tgz"
    action :run
end


include_recipe "db_mysql::install_mysql"

