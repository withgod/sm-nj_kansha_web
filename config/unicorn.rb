worker_processes 2
preload_app true
timeout 30

#listen "0.0.0.0:8088"

working_directory File.dirname(__FILE__) + '/../'

pid         "tmp/pids/unicorn.pid"
stderr_path "log/unicorn.stdout.log"
stdout_path "log/unicorn.stderr.log"
listen      '/tmp/unicorn_kansha.sock'

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      # SIGTTOU だと worker_processes が多いときおかしい気がする
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
    ActiveRecord::Base.establish_connection
end

