class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :s1
      t.string :s2
      t.string :s3
      t.string :s4
      t.string :theme

      t.timestamps
    end
  end
end
