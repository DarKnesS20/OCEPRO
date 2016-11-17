require 'yaml'

namespace :db do
  def backup_prep
    @directory = File.join(Rails.root, 'db', 'backup')
    @db = YAML::load( File.open( File.join(Rails.root, 'config', 'database.yml') ) )[ Rails.env ]
    @db_params = "-u #{@db['username']} #{@db['database']}"
    @db_params = "-p#{@db['password']} #{@db_params}" unless @db['password'].blank?
  end

  desc 'Backup database by mysqldump'
  task :backup => :environment do
    backup_prep
    FileUtils.mkdir @directory unless File.exists?(@directory)
    file = File.join( @directory, "#{Rails.env}_#{DateTime.now.to_s}.sql" )
    command = "mysqldump #{@db_params} | gzip > #{file}.gz" #--opt --skip-add-locks 
    puts "dumping to #{file}..."
    # p command
    exec command
  end

  desc "restore most recent mysqldump (from db/backup/*.sql.*) into the current environment's database."
  task :restore => :environment do
    unless Rails.env=='development'      
      puts "Are you sure you want to import into #{Rails.env}?! [y/N]"
      return unless STDIN.gets =~ /^y/i
    end
    backup_prep
    wildcard  = File.join( @directory, ENV['FILE'] || "#{ENV['FROM']}*.sql*" )
    puts file = `ls -t #{wildcard} | head -1`.chomp  # default to file, or most recent ENV['FROM'] or just plain most recent
    if file =~ /\.gz(ip)?$/
      command = "gunzip < #{file} | mysql #{@db_params}"
    else
      command = "mysql #{@db_params} < #{file}"
    end
    p command
    puts "please wait, this may take a minute or two..."
    exec command
  end
  
end
