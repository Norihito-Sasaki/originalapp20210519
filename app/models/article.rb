class Article < ApplicationRecord
  belongs_to :user
  
  has_many :interpretations, dependent: :destroy
  has_many :simplify_by, through: :interpretations, source: :user
end
