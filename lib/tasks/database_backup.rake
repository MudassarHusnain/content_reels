# lib/tasks/backup_database.rake

namespace :db do
    desc 'Create a backup of the PostgreSQL database'
    task backup: :environment do
      # Configuration
      database_name = ActiveRecord::Base.connection.current_database
      backup_directory = Rails.root.join('db', 'backups')
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      backup_filename = "#{database_name}_backup_#{timestamp}.sql.gz"
  
      # Ensure the backup directory exists
      FileUtils.mkdir_p(backup_directory)
  
      # Define the full path to the backup file
      backup_path = File.join(backup_directory, backup_filename)
  
      # Run pg_dump command to create the backup
      pg_dump_command = "PGPASSFILE=~/.pgpass pg_dump -U postgres -w #{database_name} | gzip > #{backup_path}"
      system(pg_dump_command)
  
      if $?.success?
        puts "Database backup saved to #{backup_path}"
        l= Logger.new(File.join(Rails.root, 'log',"#{task}.log"))
        l.progname = task
        l.info
      else
        puts "Database backup failed"
      end
    end
  end
  