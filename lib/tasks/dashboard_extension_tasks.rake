namespace :radiant do
  namespace :extensions do
    namespace :dashboard do
      
      desc "Runs the migration and update tasks of the Dashboard extension"
      task :install => [:environment, :migrate, :update]
      
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
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
        unless DashboardExtension.root.starts_with? RAILS_ROOT # don't need to copy vendored tasks
          puts "Copying rake tasks from DashboardExtension"
          local_tasks_path = File.join(RAILS_ROOT, %w(lib tasks))
          mkdir_p local_tasks_path, :verbose => false
          Dir[File.join DashboardExtension.root, %w(lib tasks *.rake)].each do |file|
            cp file, local_tasks_path, :verbose => false
          end
        end
      end  
    end
  end
end
