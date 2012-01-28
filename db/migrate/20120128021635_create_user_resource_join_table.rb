class CreateUserResourceJoinTable < ActiveRecord::Migration
  def up
    create_table :resources_users, :id => false do |t|
      t.integer :resource_id
      t.integer :user_id
    end
  end

  def down
    drop_table :users_resources
  end
end
