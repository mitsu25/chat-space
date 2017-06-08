class Message < ApplicationRecord
#-------Association------------------------
  belongs_to :user
  belongs_to :message
  mount_uploader :image, ImageUploader

#------validation--------------------------
validates :body    , presence: true, unless: :image?
validates :user_id , presence: true
validates :group_id, presence: true

end
