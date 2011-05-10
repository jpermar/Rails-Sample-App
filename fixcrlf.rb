def list(theDir)
  Dir.foreach(theDir) do |entry|
    #skip "." and ".."
    full = File.absolute_path(entry, theDir)
    if File.directory?(full) && (File.basename(entry) != ".") && (File.basename(entry) != "..")
      #puts "Recursing into " << full
      list(full)
    else
      if (File.basename(entry) != ".") && (File.basename(entry) != "..")
        #if !File::directory?(full)
        # puts(full)
        # we can update with dos2unix -D
        # check if text file
        #puts(full)
        if $files.include?(entry) || $extensions.include?(File.extname(entry))
          #full = File.absolute_path(full)
          puts "Updating " << full
          str = "dos2unix -D #{full}"
          system(str)
        end

      end
    end
  end
end

#$files = [ '.gitignore', 'Gemfile.lock', 'README', 'Rakefile', 'application_controller.rb', 'application_helper.rb', 'application.html.erb',
#  'config.ru', 'application.rb', 'boot.rb', 'database.yml', 'environment.rb', 'development.rb', 'production.rb', 'test.rb', 'backtrace_silencers.rb',
#  'inflections.rb', 'mime_types.rb', 'secret_token.rb', 'session_store.rb', 'en.yml', 'routes.rb', 'seeds.rb', 'README_FOR_APP', '404.html', '422.html',
#  '500.html', 'index.html', 'application.js', 'controls.js', 'dragdrop.js', 'effects.js', 'prototype.js', 'rails.js', 'robots.txt', 'rails',
#  'browsing_test.rb', 'test_helper.rb', 'microposts_controller.rb', 'users_controller.rb', 'microposts_helper.rb', 'users_helper.rb', 'micropost.rb',
#  'user.rb', '_form.html.erb', 'edit.html.erb', 'index.html.erb', 'new.html.erb', 'show.html.erb', '20110509172106_create_users.rb',
#  '20110509195359_create_microposts.rb', 'scaffold.css', 'microposts.yml', 'users.yml', 'micropost_controller_test.rb', 'microposts_controller_test.rb',
#  'users_controller_test.rb', 'microposts_helper_test.rb', 'users_helper_test.rb', 'micropost_test.rb', 'user_test.rb', '.rspec', 'spec_helper.rb' ]

$files = [ '.gitignore', 'Gemfile.lock', 'README', 'Rakefile', 'config.ru', 'README_FOR_APP', 'robots.txt', 'rails', '.rspec' ]

$extensions = [ '.rb', '.html', '.erb', '.yml', '.js', '.css' ]

list(".")
