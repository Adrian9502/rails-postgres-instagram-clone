class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @is_following = current_user.following.include?(@user) if current_user
  end
end
