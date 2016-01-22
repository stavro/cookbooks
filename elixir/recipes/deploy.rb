app = search(:aws_opsworks_app).first
app_path = "/srv/#{app['shortname']}"
# app_path = "/srv/sched_web"

directory '/srv/sched_web/tarball' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

local_tarball = ::File.join(app_path, 'latest.tar.gz')

remote_file local_tarball do
  source "https://s3.amazonaws.com/hello-phoenix-rel/latest.tar.gz"
  owner 'root'
  group 'root'
  mode '0755'
end

bash 'extract_module' do
  cwd ::File.dirname(local_tarball)

  code <<-EOH
    tar xzf latest.tar.gz
  EOH
end

bash 'start' do
  code "/srv/sched_web/bin/hello_phoenix start"
end
