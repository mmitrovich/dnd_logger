class CreateAdminUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_users do |t|
      t.string :user_name
      t.string :password_digest

      t.timestamps
    end

    add_index :admin_users, :user_name
  end

  def down
  	drop_table :admin_users
  end
end
