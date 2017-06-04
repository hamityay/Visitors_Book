class CommentsController < ApplicationController

  def create
    parent
    @comment = @parent.comments.new(comment_params)
    @comment.sender_id = current_user.id
    @comment.receiver_id = @parent.id
    if @comment.save
      if @parent.class == User
        redirect_to user_profile_path(@parent), notice: "Duvarına yazınız eklendi."
      else
        redirect_to @parent, notice: "Mekan ile ilgili yorumunuz kaydedildi."
      end
    else
      redirect_to @parent, notice: "Yorum kaydedilemedi."
    end
  end

  def destroy
    parent
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.destroy!
      if @parent.class == User
        redirect_to user_profile_path(@parent)
      else
        redirect_to @parent, notice: "Yorumunuz silindi."
      end
    else
      redirect_to @parent, notice: "Yorumunuz silinemedi."
    end
  end

  private
    def parent
      @parent = Place.find(params[:place_id]) if params[:place_id]
      @parent = User.find(params[:user_id]) if params[:user_id]
    end

    def comment_params
      params.require(:comment).permit(:body, :sender_id, :receiver_id)
    end
end
