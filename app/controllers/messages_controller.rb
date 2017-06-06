class MessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @groups = Group.joins(:users).where(users: {id:current_user.id}).includes(:users, :messages)
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @group.save
      flash.keep[:notice] = "メッセージを投稿しました。"
      redirect_to group_path(params[:group_id])
    else
      render controller: :groups, action: :show
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id:current_user.id,group_id:params[:group_id])
  end
end
