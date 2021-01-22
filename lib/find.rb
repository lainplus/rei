module Find
  def self.interpret(command)
    responses = []

    match = command.match(/^find\s+(?:me\s+)?(?:all\s+)?(\S+\s+)?files(?:\s+in\s+(\S+))?(?:\s+that\s+contain\s+(.+))?$/i)

    if match
      directory = match[2] ? match[2].strip : "."
      contains = match[3] ? match[3].strip : nil

      if contains
        # pattern for grep --include
        # must have ',' in the end in case there is only one extension
        pattern = match[1] ? "\\*.\{#{ match[1].strip },\}" : "\\*"

        responses << {
          :command => "grep --include=#{ pattern } -Rn #{ contains } #{ directory }",
          :explanation => "find files in #{ directory } with name matching "\
                          "#{ pattern } that contain '#{ contains }'."
        }
      else
        if match[1]
          # replace ',' with '|' for egrep pattern
          extensions = match[1].strip.gsub(',', '|')
          pattern = "\\.(#{ extensions })$"
        else
          pattern = ".*"
        end

        responses << {
          :command => "find #{ directory } | egrep '#{ pattern }'",
          :explanation => "find files in #{ directory } with name "\
                          "matching #{ pattern}."
        }
      end
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "find",
      :description => '\033[34mFind\033[0m files',
      :usage => ["rei find me all files that contain california",
      "rei find all rb files in ./lib/",
      "rei find all txt files"]
    }
    commands
  end
end

$executors << Find
