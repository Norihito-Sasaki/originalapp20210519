class Article < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :theme, presence: true
  
  has_many :interpretations, dependent: :destroy
  has_many :simplify_by, through: :interpretations, source: :user
end
