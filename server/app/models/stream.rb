class Stream
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :campaign_id, Integer
  property :user_id, Integer
  property :timestamp, Integer
  property :type, String

  belongs_to :user
  belongs_to :campaign

  has 1, :stream_narrative
end
