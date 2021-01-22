module RockPaperScissors
  def self.interpret(command)
    responses = []
    
    possible_moves = ['rock', 'paper', 'scissors']

    if command.match(/^(rock|paper|scissors)$/)
      user_hand = $1
      rei_hand = possible_moves.fetch(rand(3))
 
      if user_hand == rei_hand
        result = "Tie"
      elsif (user_hand == 'rock' && rei_hand == 'scissors' ) ||
            (user_hand == 'paper' && rei_hand == 'rock') ||
            (user_hand == 'scissors' && rei_hand == 'paper' )
	result = "you won"
      elsif (user_hand == 'scissors' && rei_hand == 'rock') ||
            (user_hand == 'rock' && rei_hand == 'paper') ||
            (user_hand == 'paper' && rei_hand == 'scissors')
	result = "rei won"
      end
      
      responses << {
        :say => "you got: \e[0;94;49m#{user_hand}\e[0m and rei got: \e[0;94;49m#{rei_hand}\e[0m ....... #{result}",
        :explanation => "play rock, paper, scissors with rei"
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "RockPaperScissors",
      :description => 'play rock, paper, scissors with rei',
      :usage => ["rock", "paper", "scissors"]
    }
    commands
  end
end

$executors <<  RockPaperScissors
