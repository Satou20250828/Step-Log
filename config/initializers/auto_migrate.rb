# config/initializers/auto_migrate.rb
if Rails.env.production? && ENV['AUTO_MIGRATE_ON_BOOT'] == 'true'
  Rails.application.config.after_initialize do
    puts "Checking for pending migrations..."
    ActiveRecord::Tasks::DatabaseTasks.migrate
    puts "Migrations finished!"
  end
end
