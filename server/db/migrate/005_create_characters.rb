migration 5, :create_characters do
  up do
    create_table :characters do
      column :id, DataMapper::Property::Integer, :serial => true
      column :campaign_id, DataMapper::Property::Integer
      column :user_id, DataMapper::Property::Integer
      column :name, DataMapper::Property::String
      column :bio, DataMapper::Property::Text
      column :stats, DataMapper::Property::Text
    end
  end

  down do
    drop_table :characters
  end
end
