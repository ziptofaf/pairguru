class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :movie, foreign_key: true, null: false
      t.string :content

      t.timestamps
    end
    add_index :comments, [:user_id, :movie_id], unique: true
  end
end
