class GroupsController < ApplicationController
  before_action :get_group, only: [:edit, :update, :show]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash.keep[:notice] = "新規グループが作成されました"
      redirect_to messages_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash.keep[:notice] = "チャットグループが更新されました"
      redirect_to messages_path
    else
      render :edit
    end
  end

  def show
    @groups = Group.all
    @message = Message.new
  end

  private
  def get_group
    @group = Group.find(params[:id])
  end
  # paramsからgroupnameとuser_group_idsを取得するメソッド
  def group_params
    params.require(:group).permit(:name, {user_ids: []})
  end
end
