maintainer       "Lopaka Delp"
maintainer_email "lopaka@readaccess.com"
license          'Apache v2.0'
description      "Installs/configures a MongoDB server."
long_description "Installs/configures a MongoDB server."
version          "0.0.1"

recipe  "db_mongodb::default", "downloads and untars mongodb."
recipe  "db_mongodb::install_mongodb", "installs mongodb into /usr/local/bin/"
recipe  "db_mongodb::clean_source", "cleans source files"
