class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(name:group_params[:name],user_ids:user_ids)
    # create_records_on_user_group_table(@group)
    render action: :new
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
