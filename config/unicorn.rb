worker_processes 2
preload_app true
timeout 30

listen "0.0.0.0:8088"

working_directory File.dirname(__FILE__) + '/../'

pid         "tmp/pids/unicorn.pid"
stderr_path "log/unicorn.stdout.log"
stdout_path "log/unicorn.stderr.log"

after_fork do |server, worker|
    ActiveRecord::Base.establish_connection
end

