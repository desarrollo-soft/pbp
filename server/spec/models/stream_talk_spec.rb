require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "StreamTalk Model" do
  let(:stream_talk) { StreamTalk.new }
  it 'can be created' do
    stream_talk.should_not be_nil
  end
end
