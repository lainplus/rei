require 'spec_helper'

describe 'RockPaperScissors' do

  context 'rock' do
    it { should 
           include(:explanation => "play rock, paper, scissors with rei")
       }
  end

end
