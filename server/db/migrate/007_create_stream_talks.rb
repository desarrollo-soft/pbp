migration 7, :create_stream_talks do
  up do
    create_table :stream_talks do
      column :id, DataMapper::Property::Integer, :serial => true
      column :stream_id, DataMapper::Property::Integer
      column :character_id, DataMapper::Property::Integer
      column :target_character_id, DataMapper::Property::Integer
      column :text, DataMapper::Property::Text
    end
  end

  down do
    drop_table :stream_talks
  end
end
