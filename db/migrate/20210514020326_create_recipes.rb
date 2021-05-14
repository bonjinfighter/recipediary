class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :content
      t.string :image
      t.date :date

      t.timestamps
    end
  end
end
