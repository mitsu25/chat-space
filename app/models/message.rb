class Message < ApplicationRecord
#-------Association------------------------
  belongs_to :user
  belongs_to :message
  mount_uploader :image, ImageUploader

#------validation--------------------------
  validate :message_validation

  private
  def message_validation
    if ( validates_absence_of :body ) && ( validates_absence_of :image )
      errors.add(:message, "テキスト入力または画像添付が必要です")
    end
  end
end
