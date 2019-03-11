class CreateBuyNotifications < ActiveRecord::Migration[5.2]
  def change
    drop_table :buy_notifications
  end
end
