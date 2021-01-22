require 'spec_helper'

describe 'Fun' do

  context 'undo git add' do
    it { responds_with say: "to undo a single file use\n\ngit reset filespec\n\n\nto undo ALL files added (i.e. you want to undo git add .) then use\n\ngit reset" }
  end

end
