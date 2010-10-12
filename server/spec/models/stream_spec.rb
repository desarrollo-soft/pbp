require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Stream Model" do
  let(:stream) { Stream.new }
  it 'can be created' do
    stream.should_not be_nil
  end
end
