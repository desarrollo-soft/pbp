class StreamRoll
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :stream_id, Integer
  property :explanation, String
  property :roll_type, String
  property :result, Integer
  property :public, Integer
end
