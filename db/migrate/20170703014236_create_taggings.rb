class CreateTaggings < ActiveRecord::Migration[5.1]
  def up
    create_table :taggings do |t|
      t.belongs_to :tag
      t.belongs_to :entry

      t.timestamps
    end
  end

  def down
  	drop_table :taggings
  end
end
