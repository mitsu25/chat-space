class Group < ApplicationRecord
  #-----------Association---------------
  has_many :users_groups
  has_many :users, through: :users_groups

  #-----------validation----------------
  validates :name, presence: true
end
