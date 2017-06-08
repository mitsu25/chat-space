class MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :get_group, only: [:index, :create]

  def index
    @groups = current_user.groups.includes(:messages)
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash.keep[:notice] = "メッセージを投稿しました。"
      redirect_to group_messages_path(@group)
    else
      flash.keep[:alert] = "テキストを入力するか画像を添付してください。"
      redirect_to group_messages_path(@group)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id:current_user.id,group_id:params[:group_id])
  end

  def get_group
    @group  = Group.find(params[:group_id])
  end
end
