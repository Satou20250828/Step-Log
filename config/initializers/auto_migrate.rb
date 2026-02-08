# config/initializers/auto_migrate.rb
# NOTE: Running migrations during web boot can significantly slow cold starts.
# Use a release command (e.g. Render "Release Command") to run migrations instead.
if Rails.env.production? && ENV["AUTO_MIGRATE_ON_BOOT"] == "true"
  if ENV["RUN_MIGRATIONS"] == "true"
    Rails.application.config.after_initialize do
      Rails.logger.info("Checking for pending migrations...")
      ActiveRecord::Tasks::DatabaseTasks.migrate
      Rails.logger.info("Migrations finished!")
    end
  else
    Rails.logger.warn(
      "AUTO_MIGRATE_ON_BOOT is set, but RUN_MIGRATIONS is not. " \
      "Skipping migrations to avoid slow web boot."
    )
  end
end
