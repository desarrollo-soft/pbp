require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "StreamRoll Model" do
  let(:stream_roll) { StreamRoll.new }
  it 'can be created' do
    stream_roll.should_not be_nil
  end
end
