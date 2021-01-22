# template for extensibility. put your own command for rei in here

module Template

  def self.interpret(command)
    responses = []

    if command.match(/^$/)
      search_term = $1.gsub(' ', '%20')

      responses << {
        :command => "",
        :explanation => ""
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "",
      :description => '',
      :usage => [""]
    }
    commands
  end
end

