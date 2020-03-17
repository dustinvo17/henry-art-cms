class RemoveThemeFromSettings < ActiveRecord::Migration[6.0]
  def change

    remove_column :settings, :theme, :string
  end
end
