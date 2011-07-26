#case node[:platform]
#when "centos","fedora","suse"
# 
#  # edit files /etc/tomcat6/tomcat6.conf and /etc/tomcat6/server.xml
#  # replace port 8080 with port 8000
#  tomcat_conf_files = [ '/etc/tomcat6/tomcat6.conf', '/etc/tomcat6/server.xml' ]
#  tomcat_conf_files.each do |conf_file|
#    if (File.exists?(conf_file))
#      file_text = File.read(conf_file)
#      file_text.gsub(/8080/, "8000")
#      file conf_file do
#          owner "root"
#          group "root"
#          mode "0644"
#          action :create
#          backup 5
#          content file_text
#      end
#    else
#      log "#{conf_file} does not exist"
#    end
#  end
#else
#    log "nothing done yet for non centos"
#end

