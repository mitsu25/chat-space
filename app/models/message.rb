class Message < ApplicationRecord
#-------Association------------------------
  belongs_to :user
  belongs_to :message
  mount_uploader :image, ImageUploader

#------validation--------------------------
validates :body, presence: true, unless: :image?

end
