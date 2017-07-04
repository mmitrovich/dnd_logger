class CreateTags < ActiveRecord::Migration[5.1]
  def up
    create_table :tags do |t|
      t.string :tag_name
      t.string :tag_type

      t.timestamps
    end
  end

  def down
  	drop_table :tags
  end
end
