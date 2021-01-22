module Files
  def self.interpret(command)
     responses = []
     
     ## create file
     if command.match(/create\s+([new\s]?)+file(s?)/i)
        files = command.sub(/create\s+([new\s]?)+file(s?)/i,'').strip.split(' ')
        responses <<{
          :command => "touch #{files.join(' ')}",
          :explanation => "create file(s)."
        }
     end

     ## create folder
     if command.match(/(create|make)\s+([new\s]?)+(folder(s?)|dir|director(y|ies))(s?)\s/i)
        files = command.sub(/(create|make)\s+([new\s]?)+(folder(s?)|dir|director(y|ies))(s?)\s/i,'').strip.split(' ')
        responses << {
          :command => "mkdir #{files.join(' ')}",
          :explanation => "create folder(s)"
        }
       end

     ## rename file/folder
     if command.match(/rename\s+(file|folder)\s/i)
       paths = command.sub(/rename\s+(file|folder)\s/,'').strip.split(' ')
       
       if !(paths.size<2 || paths.size > 3) 
         paths -= ["to"] if(paths.size==3)
         old_f, new_f = paths
         
         responses << {
           :command => "mv #{old_f} #{new_f}",
           :explanation => "rename file/folder"
         }
       end
     end

     ## delete file(s)
     if command.match(/(delete|remove)\s+file(s?)\s/)
       paths = command.sub(/(delete|remove)\s+file\s/,'').strip.split(' ')
     
       responses << {
         :command => "rm #{paths.join(' ')}",
         :explanation => "remove file(s)"
       }
     end
     
     ## delete folder(s)
     if command.match(/(delete|remove)\s+folder(s?)\s/) || 
         command.match(/(delete|remove)\s+all\s+(file(s?))\s+in\s/)
         paths = command.sub(/(delete|remove)\s+folder(s?)\s/,'').strip.split(' ')
     
         responses << {
           :command => "rm -r #{paths.join(' ')}",
           :explanation => "remove folder(s)"
         }
     end

     ## delete files and folders
     if command.match(/cleanup\s+folder(s?)\s/) || command.match(/force\s+cleanup\s+folder(s?)\s/)
        paths = command.sub(/cleanup\s+folder(s?)\s/,'').strip.split(' ')
        flags = "-r "
        flags += command.match(/force/) ? '-f ' : ''
     
        responses << {
          :command => "rm #{flags} #{paths.join(' ')}",
          :explanation => "removes all files and folders in give folder"
        }
     end

     ## copy, move, scp files/folders
     if action = command.match(/(copy|move)\s+(file(s?)|folder(s?)\s+)?(from\s+)?/i)
       paths = command.sub(/(copy|move)\s+(file(s?)|folder(s?)\s+)?(from\s+)?/i, '').strip.split(' ')
       if !(paths.size > 3 || paths.size < 2)
         paths -= ['to'] if paths.size == 3  # remove 'to' if exists

         source, destination = paths

         ## remote transfer - suggestion required
         if (source.split('@')[1].split(':')[0].match(/(.com|\d+)/) rescue false)|| (destination.split('@')[1].split(':')[0].match(/(.com|\d+)/) rescue false)
           flags = ""
           flags += (File.directory?(source) || File.directory?(destination)) ? "-r " : ''
         
           responses << {
             :command => "scp #{flags}#{source} #{destination}",
             :explanation => "remote transfer"
           }
         else
           if action[1].downcase == 'move' 
             responses << {
               :command => "mv #{source} #{destination}",
               :explanation => "moves the file/folder"
             }
           elsif action[1].downcase == 'copy'
             flags = ""
             flags += File.directory?(source) ? "-R " : ''
             responses << {
               :command => "cp #{flags}#{source} #{destination}",
               :explanation => "copies the file/folder"
             }
           end
         end
       end # path
     end

     responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Files",
      :usage =>[ "- rei create file fop.txt",
        "- rei create new file foo.txt",
        "- rei create files foo.txt bar.txt",
        "- rei create new files foo.txt bar.txt",
        "- rei create folder foo",
        "- rei create folders foo bar",
        "- rei create directory foo",
        "- rei create directories foo bar",
        "- rei create new folder foo",
        "- rei make directory foo",
        "- rei make directories foo bar",
        "- rei copy file my.txt to usr/",
        "- rei move file my.txt to usr/",
        "- rei copy folder my_songs/ to backup/",
        "- rei move folder my_songs/ to backup/",
        "- rei delete file junk.txt",
        "- rei remove file junk.txt",
        "- rei delete folder logs/",
        "- rei remove folder logs/",
        "- rei cleanup folder logs/",
        "- rei force cleanup folder logs/"
      ]
    }
  end
end

$executors << Files
