default["haproxy"]["admin_port"] = 8040
default["haproxy"]["services"]["api"]["host"] = ""       # node_attribute

default['haproxy']['incoming_port'] = 80
default['haproxy']['balance_algorithm'] = "roundrobin"
default['haproxy']['member_max_connections'] = 100
default['haproxy']['enable_admin'] = true
default['haproxy']['admin']['address_bind'] = "127.0.0.1"
default['haproxy']['admin']['port'] = 22002

default['haproxy']['member_port'] = 8080
default['haproxy']['app_server_role'] = "webserver"
default['haproxy']['enable_ssl'] = false
default['haproxy']['ssl_incoming_address'] = "0.0.0.0"
default['haproxy']['ssl_incoming_port'] = 443
default['haproxy']['ssl_member_port'] = 8443
default['haproxy']['httpchk'] = nil
default['haproxy']['ssl_httpchk'] = nil

default['haproxy']['pid_file'] = "/var/run/haproxy.pid"

default['haproxy']['defaults_options'] = ["httplog", "dontlognull", "redispatch"]
default['haproxy']['x_forwarded_for'] = false
default['haproxy']['defaults_timeouts']['connect'] = "5s"
default['haproxy']['defaults_timeouts']['client'] = "50s"
default['haproxy']['defaults_timeouts']['server'] = "50s"

default['haproxy']['user'] = "haproxy"
default['haproxy']['group'] = "haproxy"

default['haproxy']['global_max_connections'] = 4096

default['haproxy']['frontend_max_connections'] = 2000
default['haproxy']['frontend_ssl_max_connections'] = 2000

case platform
when "fedora", "redhat", "centos"
  default["haproxy"]["platform"] = {
    "haproxy_packages" => [ "haproxy" ],
    "haproxy_service" => "haproxy",
    "haproxy_process_name" => "haproxy",
    "service_bin" => "/sbin/service",
    "package_options" => ""
  }
when "ubuntu", "debian"
  default["haproxy"]["platform"] = {
    "haproxy_packages" => [ "haproxy" ],
    "haproxy_service" => "haproxy",
    "haproxy_process_name" => "haproxy",
    "service_bin" => "/usr/sbin/service",
    "package_options" => "--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
end
