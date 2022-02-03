namespace :deploy do
  after 'deploy:started', :skip_tasks
  after 'deploy:started', :add_flags

  after 'deploy:finished', :run_services

  task :run_services do
    invoke! 'deploy:install_node_packages'
    invoke! 'deploy:build_webpacker'
    invoke! 'deploy:stop_sidekiq_service'
    invoke! 'deploy:stop_puma_service'
    invoke! 'deploy:start_puma_service'
    invoke! 'deploy:start_sidekiq_service'
  end

  task :install_node_packages do
    on roles(:app) do
      info "Install Yarn and packages"
      execute "cd #{current_path}; npm install -g yarn && yarn install --check-files"
    end
  end

  task :build_webpacker do
    on roles(:app) do
      info "Build webpacker"
      execute "cd #{current_path}; NODE_ENV=production RAILS_ENV=production bundle exec rails assets:precompile --trace"
    end
  end

  task :stop_puma_service do
    on roles(:app) do
      info "Stop Puma application: vac-app.service"
      execute "sudo systemctl stop vac-app.service"
    end
  end

  task :start_puma_service do
    on roles(:app) do
      info "Start Puma application: vac-app.service"
      execute "sudo systemctl start vac-app.service"
    end
  end

  task :stop_sidekiq_service do
    on roles(:app) do
      info "Stop Sidekiq application: vac-sidekiq.service"
      execute "sudo systemctl stop vac-sidekiq.service"
    end
  end

  task :start_sidekiq_service do
    on roles(:app) do
      info "Start Sidekiq application: vac-sidekiq.service"
      execute "sudo systemctl start vac-sidekiq.service"
    end
  end

  task :skip_tasks do
    # Rake::Task["deploy:migrate"].clear_actions
  end

  task :add_flags do
    on roles(:app) do
      info "Add flags"
      execute "bundle config build.pg --with-pg-config=/usr/pgsql-13/bin/pg_config"
    end
  end
end
