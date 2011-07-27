maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
#license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Installs the tomcat application server."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends "db_mysql"
depends "repo_git"
depends "repo_git_pull(url, branch, dest, cred)"
 
recipe  "app_tomcat::default", "Installs the tomcat application server."
recipe  "app_tomcat::do_update_code", "Update application source files from the remote repository."
recipe  "app_tomcat::setup_db_connection", "Setup MySQL database db.tomcat connection file."
recipe  "app_tomcat::setup_tomcat_application_vhost", "Setup application vhost on port 8000"

attribute "tomcat",
  :display_name => "Tomcat Application Settings",
  :type => "hash"
#
# optional attributes
#
attribute "tomcat/modules_list",
  :display_name => "Tomcat modules",
  :discription => "An optional list of Tomcat modules to install",
  :type => "array",
  :recipes => [  "app_tomcat::default" ] 

attribute "tomcat/db_schema_name",
  :display_name => "Database Schema Name",
  :description => "Enter the name of the MySQL database schema to which applications will connect.  The database schema was created when the initial database was first set up.  This input will be used to set the application server's database config file so that applications can connect to the correct schema within the database.  This input is also used for MySQL dump backups in order to determine which schema is getting backed up.  Ex: mydbschema",
  :required => false,
  :recipes => [ "app_tomcat::setup_db_connection"  ]

attribute "tomcat/db_name",
  :display_name => "Database Name",
  :description => "Enter the name of the MySQL database to use. Ex: mydatabase",
  :required => true,
  :recipes => [ "app_tomcat::setup_db_connection"  ]

attribute "tomcat/code",
  :display_name => "Tomcat Application Code",
  :type => "hash"
  
attribute "tomcat/code/url",
  :display_name => "Repository URL",
  :description => "Specify the URL location of the repository that contains the application code. Ex: git://github.com/mysite/myapp.git",
  :required => true,
  :recipes => [ "app_tomcat::do_update_code", "app_tomcat::do_db_restore",  "app_tomcat::default" ]

attribute "tomcat/code/credentials",
  :display_name => "Repository Credentials",
  :description => "The private SSH key of the git repository.",
  :required => false,
  :default => "",
  :recipes => [ "app_tomcat::do_update_code", "app_tomcat::do_db_restore",  "app_tomcat::default" ]

attribute "tomcat/code/branch",
  :display_name => "Repository Branch",
  :description => "The name of the branch within the git repository where the application code should be pulled from.",
  :default => "master",
  :recipes => [ "app_tomcat::do_update_code", "app_tomcat::do_db_restore",  "app_tomcat::default" ]
