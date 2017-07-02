class CreateEntries < ActiveRecord::Migration[5.1]
  def up
    create_table :entries do |t|
      t.text :description
      t.belongs_to :log_book

      t.timestamps
    end
  end

  def down
  	drop_table :entries
  end
end
