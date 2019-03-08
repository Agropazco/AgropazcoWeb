class AddInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tel, :string
    add_column :users, :tel_op, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
  end
end
