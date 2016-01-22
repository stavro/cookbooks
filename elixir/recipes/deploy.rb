# include_recipe 'build-essential'

app = search(:aws_opsworks_app).first
app_path = "/srv/#{app['shortname']}"

puts app.inspect

# package node['django-demo']['mysql_package_name']

# package 'git' do
#   # workaround for:
#   # WARNING: The following packages cannot be authenticated!
#   # liberror-perl
#   # STDERR: E: There are problems and -y was used without --force-yes
#   options '--force-yes' if node['platform'] == 'ubuntu' && node['platform_version'] == '14.04'
# end


# src_filename = "foo123-nginx-module-v#{
#   node['nginx']['foo123']['version']
# }.tar.gz"
# src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
# extract_path = "#{
#   Chef::Config['file_cache_path']
#   }/nginx_foo123_module/#{
#   node['nginx']['foo123']['checksum']
# }"
#
# remote_file 'src_filepath' do
#   source node['nginx']['foo123']['url']
#   checksum node['nginx']['foo123']['checksum']
#   owner 'root'
#   group 'root'
#   mode '0755'
# end
#
# bash 'extract_module' do
#   cwd ::File.dirname(src_filepath)
#   code <<-EOH
#     mkdir -p #{extract_path}
#     tar xzf #{src_filename} -C #{extract_path}
#     mv #{extract_path}/*/* #{extract_path}/
#     EOH
#   not_if { ::File.exists?(extract_path) }
# end

application app_path do
  environment.update("PORT" => "80")

  remote_file 'archive_filepath' do
    source app['app_source']['url']
    owner 'root'
    group 'root'
    mode '0755'
  end
  #
  # git app_path do
  #   repository app['app_source']['url']
  #   action :sync
  # end

  # python '2'
  # virtualenv
  # pip_requirements

  # file ::File.join(app_path, 'dpaste', 'settings', 'deploy.py') do
  #   content "from dpaste.settings.base import *\nfrom dpaste.settings.local_settings import *\n"
  # end
  #
  # django do
  #   allowed_hosts ['localhost', node['cloud']['public_ipv4'], node['fqdn']]
  #   settings_module 'dpaste.settings.deploy'
  #   database 'sqlite:///dpaste.db'
  #   syncdb true
  #   migrate true
  # end
  #
  # gunicorn
end
