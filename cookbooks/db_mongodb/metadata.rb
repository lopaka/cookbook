maintainer       "Lopaka Delp"
maintainer_email "lopaka@readaccess.com"
license          'Apache v2.0'
description      "Installs/configures a MongoDB server."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe  "db_mongodb::default", "installs mongodb"
