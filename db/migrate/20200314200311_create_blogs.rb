class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.integer :blog_img
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
