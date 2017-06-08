require 'rails_helper'
describe User do
  describe '#create' do

    it "is valid with a body, a image, a user_id, a group_id" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is valid with body and without image" do
      message = build(:message, image:"")
      expect(message).to be_valid
    end

    it "is valid with image and without body" do
      message = build(:message, body:"")
      expect(message).to be_valid
    end

    it "is invalid withou neither body nor image" do
      message = build(:message, body:"", image:"")
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end

  end
end
