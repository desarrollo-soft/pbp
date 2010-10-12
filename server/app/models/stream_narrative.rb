class StreamNarrative
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :stream_id, Integer
  property :text, Text
end
