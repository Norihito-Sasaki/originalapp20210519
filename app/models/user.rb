class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :articles
  has_many :interpretations
  has_many :favorites
  has_many :fav_interpretation, through: :favorites, source: :interpretation 
  has_many :simplify, through: :interpretations, source: :articles


  def favorite(interpretation)
    self.favorites.find_or_create_by(interpretation_id: interpretation.id)
  end 

  def unfavorite(interpretation)
    favorite = self.favorites.find_by(interpretation_id: interpretation.id)
    favorite.destroy if favorite
  end 
  
  def favorite?(interpretation)
    self.fav_interpretation.include?(interpretation)
  end
  
  mount_uploader :image, ImageUploader
  
end