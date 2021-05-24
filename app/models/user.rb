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
end