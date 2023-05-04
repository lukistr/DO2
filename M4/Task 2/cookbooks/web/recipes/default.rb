package 'Install Apache web server' do
    package_name [ "apache2", "php", "php-mysql" ]
end

['bulgaria-map.png', 'index.php'].each do |file|
    cookbook_file "/var/www/html/#{file}" do
        source "#{file}"
        mode "0644"
    end
end

service 'Start and Enable Apache web server' do
    service_name "apache2"
    action [ :enable, :start, :restart ]
end

# Allow incoming traffic on port 8080
execute 'ufw allow "Apache Full"'

# Enable UFW firewall
execute 'ufw reload'

execute 'rm /var/www/html/index.html'

ruby_block "Add hosts" do
    block do
        file = Chef::Util::FileEdit.new("/etc/hosts")
        file.insert_line_if_no_match("^192.168.100.201", "192.168.100.201  web.do2.lab  web")
        file.insert_line_if_no_match("^192.168.100.202", "192.168.100.202  db.do2.lab  db")
        file.write_file
    end
end