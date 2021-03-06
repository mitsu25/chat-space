class MessagesController < ApplicationController

  before_action :get_group, only:  [:index, :create, :reload]
  before_action :get_groups, only: [:index, :create]

  def index
    @message  = Message.new
  end

  def create
    @message  = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group) }
        format.json
      end
      flash.keep[:notice] = "メッセージを投稿しました。"
    else
      flash.keep[:alert] = "テキストを入力するか画像を添付してください。"
      render :index
    end
  end

  def reload
    @messages = @group.messages.includes(:user)
    respond_to do |format|
      format.json
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id:current_user.id,group_id:params[:group_id])
  end

  def get_group
    if params[:group_id].present?
      @group  = Group.find(get_group_id)
    end
  end

  def get_group_id
      params[:group_id]
  end

  def get_groups
    @groups = current_user.groups.includes(:messages)
  end

end
