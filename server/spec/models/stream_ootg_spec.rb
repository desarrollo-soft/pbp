require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "StreamOotg Model" do
  let(:stream_ootg) { StreamOotg.new }
  it 'can be created' do
    stream_ootg.should_not be_nil
  end
end
