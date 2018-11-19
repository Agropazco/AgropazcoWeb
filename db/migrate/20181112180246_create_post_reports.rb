class CreatePostReports < ActiveRecord::Migration[5.2]
  def change
    create_table :post_reports do |t|
			t.references :user, foreign_key: true
			t.references :post, foreign_key: true
			t.string :topic
			t.text :message
			t.timestamps
    end
  end
end