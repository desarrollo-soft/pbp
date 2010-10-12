class StreamTalk
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :stream_id, Integer
  property :character_id, Integer
  property :target_character_id, Integer
  property :text, Text
end
