class AddHiddenToResource < ActiveRecord::Migration
  def change
    add_column :resources, :hidden, :boolean

  end
end
