class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:like][:post_id])
    @like = current_user.likes.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @post }
        format.turbo_stream
      else
        format.html { redirect_to @post, alert: "You already liked this post" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like_section_#{@post.id}", partial: "posts/like_section", locals: { post: @post, liked: false }) }
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @post = @like.post
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.turbo_stream
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
