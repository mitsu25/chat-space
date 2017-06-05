class User < ApplicationRecord
  has_many :users_groups
  has_many :groups, through: :users_groups

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
