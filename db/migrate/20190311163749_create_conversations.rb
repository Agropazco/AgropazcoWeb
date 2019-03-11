class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id   
      t.timestamps
    end

    create_table :messages do |t|
      t.text :body
      t.references :conversation, index: true
      t.references :user, index: true
      t.boolean :read, :default => false
      t.timestamps
    end
  end
end