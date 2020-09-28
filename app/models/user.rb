class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_one  :cart, dependent: :destroy
  accepts_nested_attributes_for :cart, allow_destroy: true

end
