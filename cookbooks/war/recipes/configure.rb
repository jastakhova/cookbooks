
directory "/tmp/app" do
  recursive true
  action :delete
end


dirname = File.dirname(node['configure']['to'])

directory "/tmp/app/WEB-INF/#{dirname}" do
  mode 0777
  owner "root"
  group "root"
  action :create
  recursive true
end

template "/tmp/app/WEB-INF/#{node['configure']['to']}" do
  source "database.properties.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
    :variables   => node['configure']['variables']
  )
end

file "/tmp/app.final.war" do
  action :delete
end

file "/tmp/app.final.war" do
  content IO.read("/tmp/app.war")
end

package "zip" do
  action :install
end

execute "fill app.final.war" do
  command "cd /tmp/app; zip -r /tmp/app.final.war *"
  action :run
end

# Creating tomcat context xml

template '/tmp/app.xml' do
  source 'context.xml.erb'
  owner 'root'
  group 'root'
  mode '0777'
  variables(
      :war => '/tmp/app.final.war'
  )
end

directory "#{node['tomcat']['webapp_dir']}/ROOT" do
  recursive true
  action :delete
end

link "#{node['tomcat']['context_dir']}/ROOT.xml" do
  to "/tmp/app.xml"
end

service "tomcat6" do
  action :restart
end