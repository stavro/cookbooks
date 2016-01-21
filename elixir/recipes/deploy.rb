# elixir/recipes/deploy.rb
#
# Cookbook Name:: elxir
# Recipe:: deploy
#

# This deploys the application
node[:deploy].each do |application, deploy|
  opsworks_deploy do
    app application
    deploy_data deploy
  end
end
