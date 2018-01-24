include_recipe "laravel::config"
bash "configure october" do
  code <<-EOT
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
  cd /var/www/
  mr -rf *
  composer create-project laravel/laravel /var/www/laravel 4.2
 
 
  chown -R :www-data /var/www/
  chmod -R 775 /var/www/laravel/app/storage
  chmod -R 755 /var/www/laravel/public
 
  EOT
end

template '/etc/apache2/sites-enabled/000-default.conf' do
	source '000-default.conf.erb'
variables ({

	:document_root	=> node['document_root']

})

end

template '/var/www/laravel/app/config/database.php' do
  source 'database.php.erb'
variables ({
        :database_hostname      => node['db_hostname'],

	:database_name		=> node['db_name'],
  	:database_user		=> node['db_user'],
  	:database_password	=> node['db_password']


   })
end

