class Stream
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :campaign_id, Integer
  property :user_id, Integer
  property :timestamp, Integer
  property :type, String
end
