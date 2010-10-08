migration 1, :create_users do
  up do
    create_table :users do
      column :id, DataMapper::Property::Integer, :serial => true
      column :username, DataMapper::Property::String
      column :password, DataMapper::Property::String
    end
  end

  down do
    drop_table :users
  end
end
