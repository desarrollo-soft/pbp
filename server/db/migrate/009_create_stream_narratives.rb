migration 9, :create_stream_narratives do
  up do
    create_table :stream_narratives do
      column :id, DataMapper::Property::Integer, :serial => true
      column :stream_id, DataMapper::Property::Integer
      column :text, DataMapper::Property::Text
    end
  end

  down do
    drop_table :stream_narratives
  end
end
