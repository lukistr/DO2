package 'Install MariaDB server' do
    package_name [ "mariadb", "mariadb-server" ]
end

cookbook_file "/tmp/db_setup.sql" do
    source "db_setup.sql"
    mode "0644"
end

execute "mysql -u root < /vagrant/db.sql" do
    not_if "mysql -u root -e 'show databases' | grep mydb"
end

firewalld_service 'mysql'

selinux_state 'permissive' do
    action :permissive
end

ruby_block "Add hosts" do
    block do
        file = Chef::Util::FileEdit.new("/etc/hosts")
        file.insert_line_if_no_match("^192.168.100.201", "192.168.100.201  web.do2.lab  web")
        file.insert_line_if_no_match("^192.168.100.202", "192.168.100.202  db.do2.lab  db")
        file.write_file
    end
end

service 'Stop DB server' do
    service_name "mariadb"
    action [ :stop ]
end
  
service 'Start DB server' do
    service_name "mariadb"
    action [ :start ]
end