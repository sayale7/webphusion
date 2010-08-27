set :application, "webphusion"
set :deploy_to, "/var/rails/#{application}"
#############################################################
# Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true

#############################################################
# Servers
#############################################################

set :user, "root"
set :domain, "178.77.73.32"
server domain, :app, :web
role :db, domain, :primary => true
set :runner, "root"

#############################################################
# GIT
#############################################################

# set :repository,  "svn://kohler-it.net/svn/violinet/trunk/"
# set :svn_username, "thomas"
# set :svn_password, "aplhma6"
# set :checkout, "export"

set :scm, "git"
set :repository, "git://github.com/sayale7/webphusion"
set :branch, "master"

#############################################################
# Passenger
#############################################################

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

    [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared_and_chmod do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/system/ #{release_path}/public/system"
    run "sudo chmod -R 777 #{release_path}/public/"
    run "sudo chmod -R 777 #{release_path}/tmp/"
    run "sudo chmod -R 777 #{shared_path}/"
    run "sudo /etc/init.d/apache2 reload"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared_and_chmod'