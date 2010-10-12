migration 11, :create_stream_privates do
  up do
    create_table :stream_privates do
      column :id, DataMapper::Property::Integer, :serial => true
      column :stream_id, DataMapper::Property::Integer
      column :target_user_id, DataMapper::Property::Integer
      column :text, DataMapper::Property::Text
    end
  end

  down do
    drop_table :stream_privates
  end
end
