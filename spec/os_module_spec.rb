require 'spec_helper'

describe 'OS' do

  context "platform name" do
    before(:all) do
      $VERBOSE = nil
      @platform = RUBY_PLATFORM
      RUBY_PLATFORM = 'darwin'
    end

    after(:all) do
      RUBY_PLATFORM = @platform
    end

    context "OS" do
      it "should return right os name on interpret method" do
        responds_with(
          {:command=>"echo 'os x'", :explanation=>"show what os is used"}
        )
      end
    end

    it "returns the right os name on platform_name method" do
      result = OS.platform_name
      expect(result).to eq("os x")
    end
  end

  context "help" do
    subject { OS.help }

    it "should return right help" do
      responds_with(
        category: "OS",
        description: 'show \033[34mOS\033[0m name',
        usage: ["show what os is used"]
      )
    end
  end
end
