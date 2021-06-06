class AddColumnsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :url1, :string
    add_column :recipes, :url2, :string
  end
end
