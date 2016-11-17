class DbBackupRestore 
  require 'yaml'

  def self.backup_prep
    @directory = File.join(Rails.root, 'db', 'backup')
    @db = YAML::load( File.open( File.join(Rails.root, 'config', 'database.yml') ) )[ Rails.env ]
    @db_params = "-u #{@db['username']} #{@db['database']}"
    @db_params = "-p#{@db['password']} #{@db_params}" unless @db['password'].blank?
  end

  def self.backup
    begin
      backup_prep
      FileUtils.mkdir @directory unless File.exists?(@directory)
      file = File.join( @directory, "#{Rails.env}_#{DateTime.now.to_s}.sql" )
      command = "mysqldump #{@db_params} | gzip > #{file}.gz" #--opt --skip-add-locks 
      puts "dumping to #{file}..."
      # p command
      system command
      true
    rescue => ex
      false
    end
  end

  def self.restore
    begin
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
      system command
      true
    rescue => ex
      false
    end
  end
end