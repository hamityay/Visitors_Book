class Hq::CommentsController < Hq::ApplicationController

  def index
    @p_comments = Comment.all.where(commentable_type: "Place")
    @u_comments = Comment.all.where(commentable_type: "User")
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.destroy!
      redirect_to hq_comments_path, notice: "Yorum silinemedi."
    end
  end

  private

end
