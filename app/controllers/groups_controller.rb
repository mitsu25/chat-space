class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: group_params[:name],user_ids: user_ids)
    if @group.save
      flash.now[:notice] = "新規グループが作成されました"
      render template: "messages/index"
    else
      render action: :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(name: group_params[:name],user_ids: user_ids)
    redirect_to messages_path
  end

  private
  # paramsからgroupnameとuser_group_idsを取得するメソッド
  def group_params
    params.require(:group).permit(:name,user_group_ids:[])
  end

  # user_group_idsの先頭の空要素を取り出して新配列を返すメソッド
  def user_ids
    user_ids = group_params[:user_group_ids]
    user_ids.shift
    return user_ids
  end

end
