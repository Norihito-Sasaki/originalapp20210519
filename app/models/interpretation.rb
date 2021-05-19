class Interpretation < ApplicationRecord
  belongs_to :article
  belongs_to :user
  
  validates :content, presence: true
  
  has_many :favorites, dependent: :destroy
  has_many :fav_by, through: :favorites, source: :user
end
