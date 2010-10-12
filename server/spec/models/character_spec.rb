require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Character Model" do
  let(:character) { Character.new }
  it 'can be created' do
    character.should_not be_nil
  end
end
