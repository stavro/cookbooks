bash "yum groupinstall Development tools" do
  user "root"
  group "root"
  code <<-EOC
    yum groupinstall "Development tools" -y
  EOC
  not_if "yum grouplist installed | grep 'Development tools'"
end

# curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -

%w(
  ncurses-devel
  java-1.8.0-openjdk-devel
  openssl-devel
  nodejs
  npm
  erlang
).each do |pkg|
  options "--enablerepo=epel"
  package pkg
end
#
# bash 'install-erlang' do
#   cwd Chef::Config[:file_cache_path]
#   code <<-EOH
#     tar -xzf otp_src_#{erlang_version}.tar.gz
#     (cd otp_src_#{erlang_version} && ./configure && make && make install)
#   EOH
#   # environment('CFLAGS' => erlang_cflags)
#   action :nothing
#   not_if "erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell | grep #{erlang_version}"
# end

#
# # dev tools to compile and build
# sudo yum groupinstall "Development Tools"
# sudo yum install ncurses-devel
# sudo yum install java-1.8.0-openjdk-devel
# sudo yum install openssl-devel

# install erlang
#
# wget http://www.erlang.org/download/otp_src_18.0.tar.gz
# tar -zxvf otp_src_18.0.tar.gz
# cd otp_src_18.0
# ./configure
# make
# make install

# get inotify

# wget http://github.com/downloads/rvoicilas/inotify-tools/inotify-tools-3.14.tar.gz
# tar -zxvf inotify-tools-3.14.tar.gz
# cd inotify-tools-3.14
# ./configure
# make
# sudo make install

# you may need to tweak inotify per https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers if you get errors
#
# # elixir
# mkdir elixir
# cd elixir
# wget https://github.com/elixir-lang/elixir/releases/download/v1.2.1/Precompiled.zip
# unzip Precompiled.zip
# rm Precompiled.zip
# export PATH=$(pwd):$PATH
#
# mix local.hex --force
#
# # Download git repo, checkout hash
#
# npm install
