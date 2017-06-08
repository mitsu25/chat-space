require 'rails_helper'
describe Message do
  describe '#create' do

    context "it is valid" do

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

    end

    context "it is invalid" do

      it "is invalid withou neither body nor image" do
        message = build(:message, body:"", image:"")
        message.valid?
        expect(message.errors[:body]).to include("を入力してください")
      end

      it "is invalid without a user_id" do
        message = build(:message, user_id:"")
        message.valid?
        expect(message.errors[:user_id]).to include("を入力してください")
      end

      it "is invalid without a group_id" do
        message = build(:message, group_id:"")
        message.valid?
        expect(message.errors[:group_id]).to include("を入力してください")
      end

    end

  end
end
