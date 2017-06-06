class MessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def create
    Message.create(message_params)
    redirect_to group_path(params[:group_id])
  end

  private
  def message_params
    params.require(:message).permit(:body,:image,:image).merge(user_id:current_user.id,group_id:params[:group_id])
  end
end
