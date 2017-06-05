class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
