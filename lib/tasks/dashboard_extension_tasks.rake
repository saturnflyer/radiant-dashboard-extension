namespace :radiant do
  namespace :extensions do
    namespace :dashboard do
      
      desc "Runs the migration of the Dashboard extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          DashboardExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          DashboardExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Dashboard to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from DashboardExtension"
        Dir[DashboardExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(DashboardExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
