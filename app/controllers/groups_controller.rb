class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(name:group_params[:name])
    create_records_on_user_group_table(@group)
    redirect_to messages_path
  end

  private
  # paramsからgroupnameとuser_group_idsを取得するメソッド
  def group_params
    params.require(:group).permit(:name,user_group_ids:[])
  end

  # user_group_idsの先頭の空要素を取り出して新配列を返すメソッド
  def get_user_ids
    user_ids = group_params[:user_group_ids]
    user_ids.shift
    return user_ids
  end

  # idsとGroupインスタンスのidで中間テーブルにレコードを残すメソッド
  def create_records_on_user_group_table(group)
    get_user_ids.each do |id|
      UserGroup.create(user_id:id,group_id:group.id)
    end
  end

end
