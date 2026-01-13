class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    @follow = current_user.follows_as_follower.build(followed_id: @user.id)

    respond_to do |format|
      if @follow.save
        format.html { redirect_to user_path(@user), notice: "You are now following #{@user.username}" }
        format.turbo_stream
      else
        format.html { redirect_to user_path(@user), alert: "Unable to follow user" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("follow_button_#{@user.id}", partial: "users/follow_button", locals: { user: @user, is_following: false }) }
      end
    end
  end

  def destroy
    @follow = current_user.follows_as_follower.find(params[:id])
    @user = @follow.followed
    @follow.destroy

    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "Unfollowed #{@user.username}" }
      format.turbo_stream
    end
  end
end
