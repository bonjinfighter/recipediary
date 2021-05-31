class Recipe < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length:{maximum:255}
  validates :title, presence: true, length:{maximum:255}
  
  has_many :favorites, class_name: 'Favorite', foreign_key: 'recipe_id', dependent: :destroy
  has_many :users, through: :favorite, source: :user

  mount_uploader :image, ImageUploader
end
