class Cart < ApplicationRecord
  belongs_to :user
  has_many :positions, dependent: :destroy
  has_many :items, through: :positions
  accepts_nested_attributes_for :positions, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true
end
