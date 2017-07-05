# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "dnd_logger"
set :repo_url, "git@github.com:mmitrovich/dnd_logger.git"

set :rails_env, 'production'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true
set :pty, true
set :user, "mike"

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :config do
  desc "Symlink application config files."
  task :symlink do
  	on roles(:all) do
    	execute "ln -s {#{shared_path},#{release_path}}/config/app_secret.yml" 
    end
  end
end


namespace :deploy do
	desc "Restart Passenger app"
	task :restart do
		on roles(:all) do
	    	execute "touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
	    end
	end


	desc 'Precompile assets locally and then rsync to web servers'
  	task :custom_compile_assets do
    # The command inside this block will run in our local machine
    run_locally do
      execute 'RAILS_ENV=production bundle exec rake assets:precompile'
      execute 'tar -zcvf assets.tar.tgz public/assets/'
      execute 'rm -rf public/assets'
       
       # This command will copy and transfer the assets.tar.tgz to username@servername.com:#{release_path}/
      execute "scp -P2222 assets.tar.tgz mike@mitrovich.no-ip.biz:#{release_path}/assets.tar.tgz"
      execute 'rm -rf assets.tar.tgz'
    end
    on roles(:all) do |host|
      # this command extracts assets.tar.tgz
      execute "cd #{release_path}; tar zxvf assets.tar.tgz"

      execute "cd #{release_path}; rm -rf assets.tar.tgz"
    end
    invoke 'deploy:restart'
  end
end



after "deploy", "config:symlink"
after "deploy", "deploy:custom_compile_assets"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"