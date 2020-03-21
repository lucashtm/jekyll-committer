class AddBlogToPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :blog, index: true
  end
end
