class GroupsController < ApplicationController
  before_action :get_group, only: [:edit, :update, :show]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash.keep[:notice] = "新規グループが作成されました"
      redirect_to group_messages_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash.keep[:notice] = "チャットグループが更新されました"
      redirect_to group_messages_path(@group)
    else
      render :edit
    end
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
