docker_installation 'default'

docker_service 'default' do
    action [:create, :start]
end
  
docker_image 'nginx' do
    action :pull
end
  
docker_container 'nginx' do
    repo 'nginx'
    tag 'latest'
    port [ '8080:80' ]
    host_name 'www'
end

# Allow incoming traffic on port 8080
#execute 'ufw allow 8080/tcp'

# Enable UFW firewall
#execute 'ufw reload'