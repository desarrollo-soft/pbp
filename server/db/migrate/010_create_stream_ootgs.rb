migration 10, :create_stream_ootgs do
  up do
    create_table :stream_ootgs do
      column :id, DataMapper::Property::Integer, :serial => true
      column :stream_id, DataMapper::Property::Integer
      column :text, DataMapper::Property::Text
    end
  end

  down do
    drop_table :stream_ootgs
  end
end
