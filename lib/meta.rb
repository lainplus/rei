module Meta  
  def self.interpret(command)
    responses = []
    
    if command.match(/^(what\s+)?version(\s+are\s+you)?$/)
      responses << {
        :say => $VERSION,
        :explanation => "gets rei's version."
      }
    end
    
    if command.match(/^whats?\s+(?:is\s+)?your\s+(website|url|github|repo)(\s+again\?)?$/) ||
       command.match(/^(website|url)$/)
      responses << {
        :say => $URL,
        :explanation => "gets rei's website."
      }
    end
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Meta",
      :usage => ["what version are you (or just rei version)",
      "whats your github again"]
    }
    commands
  end
end

$executors << Meta
