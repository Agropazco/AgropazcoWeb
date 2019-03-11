class CreateBuyNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_notifications do |t|
      t.string :message
      t.references :buyer
      t.references :seller
			t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
