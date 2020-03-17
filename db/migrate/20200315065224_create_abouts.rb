class CreateAbouts < ActiveRecord::Migration[6.0]
  def change
    create_table :abouts do |t|
      t.integer :about_img
      t.string :intro
      t.text :intro_body
      t.string :subintro
      t.text :subintro_body

      t.timestamps
    end
  end
end
