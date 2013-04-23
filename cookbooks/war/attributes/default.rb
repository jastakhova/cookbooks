case platform
  when "centos","redhat","fedora"
    set["tomcat"]["user"] = "tomcat"
    set["tomcat"]["group"] = "tomcat"
    set["tomcat"]["home"] = "/usr/share/tomcat6"
    set["tomcat"]["base"] = "/usr/share/tomcat6"
    set["tomcat"]["config_dir"] = "/etc/tomcat6"
    set["tomcat"]["log_dir"] = "/var/log/tomcat6"
    set["tomcat"]["tmp_dir"] = "/var/cache/tomcat6/temp"
    set["tomcat"]["work_dir"] = "/var/cache/tomcat6/work"
    set["tomcat"]["context_dir"] = "#{tomcat["config_dir"]}/Catalina/localhost"
    set["tomcat"]["webapp_dir"] = "/var/lib/tomcat6/webapps"
  when "debian","ubuntu"
    set["tomcat"]["user"] = "tomcat6"
    set["tomcat"]["group"] = "tomcat6"
    set["tomcat"]["home"] = "/usr/share/tomcat6"
    set["tomcat"]["base"] = "/var/lib/tomcat6"
    set["tomcat"]["config_dir"] = "/etc/tomcat6"
    set["tomcat"]["log_dir"] = "/var/log/tomcat6"
    set["tomcat"]["tmp_dir"] = "/tmp/tomcat6-tmp"
    set["tomcat"]["work_dir"] = "/var/cache/tomcat6"
    set["tomcat"]["context_dir"] = "#{tomcat["config_dir"]}/Catalina/localhost"
    set["tomcat"]["webapp_dir"] = "/var/lib/tomcat6/webapps"
  else
    set["tomcat"]["user"] = "tomcat6"
    set["tomcat"]["group"] = "tomcat6"
    set["tomcat"]["home"] = "/usr/share/tomcat6"
    set["tomcat"]["base"] = "/var/lib/tomcat6"
    set["tomcat"]["config_dir"] = "/etc/tomcat6"
    set["tomcat"]["log_dir"] = "/var/log/tomcat6"
    set["tomcat"]["tmp_dir"] = "/tmp/tomcat6-tmp"
    set["tomcat"]["work_dir"] = "/var/cache/tomcat6"
    set["tomcat"]["context_dir"] = "#{tomcat["config_dir"]}/Catalina/localhost"
    set["tomcat"]["webapp_dir"] = "/var/lib/tomcat6/webapps"
end

default['war']['deploy']['git']['url'] = ""
default['war']['deploy']['git']['revision'] = "HEAD"
default['war']['deploy']['url'] = ""

default['database']['hosts'] = ["127.0.0.1"]
default['database']['port'] = "3306"

default['haproxy']['enable_admin'] = true
default['haproxy.rebalance']['nodes'] = ["localhost"]

default['configure']['to'] = "jdbc.properties"
default['configure']['variables']['hosts'] = ['127.0.0.1']
default['configure']['variables']['port'] = "3306"