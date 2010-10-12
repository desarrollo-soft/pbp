migration 8, :create_stream_rolls do
  up do
    create_table :stream_rolls do
      column :id, DataMapper::Property::Integer, :serial => true
      column :stream_id, DataMapper::Property::Integer
      column :explanation, DataMapper::Property::String
      column :roll_type, DataMapper::Property::String
      column :result, DataMapper::Property::Integer
      column :public, DataMapper::Property::Integer
    end
  end

  down do
    drop_table :stream_rolls
  end
end
