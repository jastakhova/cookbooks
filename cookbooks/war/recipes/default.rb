#
# Cookbook Name:: petstore
# Recipe:: default
#
# Copyright 2012, Cometera
#
# All rights reserved - Do Not Redistribute
#

# Creating app war

if not node['war']['deploy']['url'].empty?
  remote_file 'app.war' do
    path '/tmp/app.war'
    source node['war']['deploy']['url']
    mode '0777'
  end
elsif not node['war']['deploy']['git']['url'].empty?
  directory "/tmp/app" do
    recursive true
    action :delete
  end

  case node[:platform]
  when "debian", "ubuntu"
    package "git-core"
  when "centos"
    if node[:platform_version].to_i < 6
    #http://stackoverflow.com/questions/3779274/how-can-git-be-installed-on-centos-5-5
      remote_file 'latest.rpm' do
        path '/tmp/latest.rpm'
        source "http://repo.webtatic.com/yum/centos/5/latest.rpm"
      end

      package "webstatic" do
        source "/tmp/latest.rpm"
        options("--nogpgcheck -y")
      end

      #because of http://tickets.opscode.com/browse/CHEF-2427 not yet merged into version 10.16.2 we use
      execute "install git-all" do
        command "yum install -y --enablerepo=webtatic git"
      end
    else
      package "git"
    end
  else
    package "git"
  end

  git "/tmp/app" do
    repository node['war']['deploy']['git']['url']
    reference node['war']['deploy']['git']['revision']
    action :sync
  end

  include_recipe "maven::maven2"

  execute "package" do
    command "cd /tmp/app; mvn clean package && cp /tmp/app/target/*.war /tmp/app.war"
  end
end


# Creating tomcat context xml

template '/tmp/app.xml' do
  source 'context.xml.erb'
  owner 'root'
  group 'root'
  mode '0777'
  variables(
      :war => '/tmp/app.war'
  )
end

directory "#{node['tomcat']['webapp_dir']}/ROOT" do
  recursive true
  action :delete
end

link "#{node['tomcat']['context_dir']}/ROOT.xml" do
  to "/tmp/app.xml"
end
