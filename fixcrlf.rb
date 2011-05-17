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
          puts "Updating LF -> CRLF for " << full
          str = "dos2unix -D #{full}"
          system(str)
        end

      end
    end
  end
end

#$files = [ '.gitignore', 'Gemfile.lock', 'README', 'Rakefile', 'config.ru', 'README_FOR_APP', 'robots.txt', 'rails', '.rspec' ]

$files = [ ] 

#$extensions = [ '.rb', '.html', '.erb', '.yml', '.js', '.css' ]

$extensions = [ '.rb' ]

list(".")
