bash "yum groupinstall Development tools" do
  user "root"
  group "root"
  code <<-EOC
    yum groupinstall "Development tools" -y
  EOC
  not_if "yum grouplist installed | grep 'Development tools'"
end

bash "add npm node 4.x source" do
  code <<-EOC
    curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
  EOC
end

%w(
  ncurses-devel
  java-1.8.0-openjdk-devel
  openssl-devel
  nodejs
  npm
).each do |pkg|
  package pkg do
    options "--enablerepo=epel"
  end
end

erlang_version = "18.2.1"

bash 'install-erlang' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    wget http://www.erlang.org/download/otp_src_#{erlang_version}.tar.gz
    tar -zxvf otp_src_#{erlang_version}.tar.gz
    cd otp_src_#{erlang_version}
    ./configure
    make
    make install
  EOH
  # environment('CFLAGS' => erlang_cflags)
  not_if "erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell | grep #{erlang_version}"
end


bash 'link erlang' do
  code <<-EOC
    export PATH=/usr/local/bin:$PATH
  EOC
end

elixir_version = "1.2.1"

bash 'install-elixir' do
  code <<-EOC
    mkdir elixir
    cd elixir
    wget https://github.com/elixir-lang/elixir/releases/download/v1.2.1/Precompiled.zip
    unzip Precompiled.zip
    rm Precompiled.zip
    export PATH=$(pwd)/bin:$PATH
    mix local.hex --force
  EOC
end

# * download repo
# * npm install
# * cd clients/bookingWidget && npm install
# * gulp dependencies
# * mix phoenix.digest
# * MIX_ENV=prod mix release

# get inotify

# wget http://github.com/downloads/rvoicilas/inotify-tools/inotify-tools-3.14.tar.gz
# tar -zxvf inotify-tools-3.14.tar.gz
# cd inotify-tools-3.14
# ./configure
# make
# sudo make install

# you may need to tweak inotify per https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers if you get errors
