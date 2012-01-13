class RemoveIndexOnLoginFromUsers < ActiveRecord::Migration
  def up
    remove_index :users, ["login"]
  end

  def down
    add_index :users, ["login"], :name => "index_users_on_login", :unique => true
  end
end
