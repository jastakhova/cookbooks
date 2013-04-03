maintainer        "Cometera"
license           "Apache 2.0"
description       "Installs and configures haproxy based on Rackspace, Inc code (https://github.com/rcbops-cookbooks/haproxy)"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.6"

%w{ centos ubuntu }.each do |os|
  supports os
end

%w{ apt openssl yum yumrepo }.each do |dep|
  depends dep
end
