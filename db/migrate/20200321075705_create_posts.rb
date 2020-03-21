class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :commit_sha
      t.string :commit_message, null: false
      t.text :content
      t.string :title, null: false
      t.string :filename

      t.timestamps
    end
  end
end
