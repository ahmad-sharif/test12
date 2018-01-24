execute "update" do
        command "apt-get update"
end


%w(unzip php7.0-mysql php7.0-curl php7.0-json php7.0-cgi php7.0 libapache2-mod-php7.0 php7.0-mcrypt php7.0-gd php7.0-mbstring php7.0-zip mysql-server).each do |p|
        package p do
                action :install
        end

end


service 'apache2' do
	action [:start,:enable]
end



