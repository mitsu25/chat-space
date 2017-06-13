class UsersController < ApplicationController

  def edit
  end

  def index
    keyword = user_params[:name]
    @users  = User.where('name LIKE(?)',"#{keyword}%").limit(10)
    respond_to do |format|
      format.json
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(name:user_params[:name],email:user_params[:email])
    redirect_to messages_path
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end

end
