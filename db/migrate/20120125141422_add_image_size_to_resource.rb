class AddImageSizeToResource < ActiveRecord::Migration
  def change
    add_column :resources, :image_size, :string
  end
end
