class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :sns_credentials
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :title, length: { maximum: 255 }

  acts_as_paranoid
  

  has_many :recipes
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :likes, through: :favorites, source: :recipe
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_recipes
    Recipe.where(user_id: self.following_ids + [self.id])
  end
  
  def feed_flollowings_recipes
    Recipe.where(user_id: self.following_ids)
  end
  
  def feed_likes
    Recipe.where(recipe_id: self.like_ids)
  end
  
  def like(recipe)
    self.favorites.find_or_create_by(recipe_id: recipe.id)
  end
  
  def unlike(recipe)
    favorite = self.favorites.find_by(recipe_id: recipe.id)
    favorite.destroy if favorite
  end
  
  def like?(recipe)
    self.likes.include?(recipe)
  end 
  
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # SNS認証sを行ったことがあるかを判断して、データベースに保存
    
    user = User.where(email: auth.info.email).first_or_initialize(
         name: auth.info.name,
         email: auth.info.email,
     )
    # SNS認証を行っていなかった場合、メールアドレスで検索
  
    # userが登録済みであるか判断
     if user.persisted?
       sns.user = user
       sns.save
     end
     { user: user, sns: sns }
  end
end
  