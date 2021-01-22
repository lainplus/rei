require 'spec_helper'

describe 'User' do

  context 'what version' do
    it { responds_with :say => $VERSION, :explanation => "gets rei's version."}      
  end
  context 'what version is openssl' do
    it { responds_with :command => "openssl version", :explanation => "gets the version of openssl."}      
  end

end
