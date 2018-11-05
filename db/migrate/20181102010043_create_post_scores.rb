class CreatePostScores < ActiveRecord::Migration[5.2]
  def change
    create_table :post_scores do |t|
      t.integer :post_id, foreign_key: true
      t.integer :scoring_user_id
      t.integer :score
      
      t.timestamps
    end
  
    add_foreign_key :post_scores, :users, column: :scoring_user_id
    add_index :post_scores, :post_id
    add_index :post_scores, :scoring_user_id
    add_index :post_scores, [:post_id, :scoring_user_id], unique: true
  end
end
