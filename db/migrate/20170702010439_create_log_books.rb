class CreateLogBooks < ActiveRecord::Migration[5.1]
  def up
    create_table :log_books do |t|
      t.string :title

      t.timestamps
    end
  end

  def down
  	drop_table :log_books
  end
end
