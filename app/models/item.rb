class Item < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :carts, through: :positions
  belongs_to :user
  #accepts_nested_attributes_for :positions, allow_destroy: true
end
