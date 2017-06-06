class Message < ApplicationRecord
  belongs_to :user
  belongs_to :message
  mount_uploader :image, ImageUploader
end
