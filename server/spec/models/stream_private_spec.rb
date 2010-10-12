require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "StreamPrivate Model" do
  let(:stream_private) { StreamPrivate.new }
  it 'can be created' do
    stream_private.should_not be_nil
  end
end
