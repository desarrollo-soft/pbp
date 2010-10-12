require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "StreamNarrative Model" do
  let(:stream_narrative) { StreamNarrative.new }
  it 'can be created' do
    stream_narrative.should_not be_nil
  end
end
