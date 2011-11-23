class InitialTables < ActiveRecord::Migration
  def self.up
    create_table :cardify_categories do |t|
      t.string :name
      t.string :description
    end
    
    create_table :cardify_icons do |t|
      t.integer :image_id
      t.integer :category_id
    end

    create_table :cardify_themes do |t|
      t.integer :image_id
      t.integer :category_id
    end

    create_table :cardify_photos do |t|
      t.integer :image_id
      t.string :title
      t.string :description
      t.integer :end_user_id
      t.integer :theme_id
      t.string :permalink
      t.timestamps
    end

    create_table :cardify_icon_placements do |t|
      t.integer :icon_id
      t.integer :photo_id
      t.integer :x
      t.integer :y
    end

    add_index :cardify_photos, :permalink
  end

  def self.down
    drop_table :cardify_categories
    drop_table :cardify_icons
    drop_table :cardify_themes
    drop_table :cardify_photos
    drop_table :cardify_icon_placements
  end
end
