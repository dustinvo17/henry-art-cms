class CreateWatercolors < ActiveRecord::Migration[6.0]
  def change
    create_table :watercolors do |t|
      t.string :imageid

      t.timestamps
    end
  end
end
