class SubcommentsController < ApplicationController
  def new
    @subcomment = Subcomment.new
  end

  def create
    @subcomment = Subcomment.new(params[:subcomment])
    @subcomment.comment_id = params[:comment_id]
    @subcomment.user_id = current_user.id
    @post = @subcomment.comment.post
    @forum = @post.forum
    @class_room = @forum.class_room
    subcomments = Comment.find(params[:comment_id]).subcomments
    users_notified = {}

        
    respond_to do |format|
      if @subcomment.save
        subcomments.each do |subcomment|
          if subcomment.user != @post.user and subcomment.user != current_user and not users_notified.include? subcomment.user
            user_notification("also_comment_subcomment","Subcomment",subcomment.user,@subcomment.id, @subcomment.comment.id)
            users_notified[subcomment.user] = subcomment.user
          end 
        end
        user_notification("new_subcomment","Subcomment",@subcomment.comment.user,@subcomment.id, @subcomment.comment.id)
        format.html  { redirect_to(@subcomment, :notice => 'Comment was successfully created.') }
        partial = render_to_string :partial => "subcomments/subcomment.html.haml", :locals => 
        {:subcomment => @subcomment, :comment => @subcomment.comment}
        format.json  { render :json => {:new_subcomment => partial} }
      else
        format.html  { redirect_to :back }
        format.json  { render :json => @subcomment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @subcomment = Subcomment.find(params[:id])
    @class_room = ClassRoom.find(params[:class_room_id])
    if @subcomment.user_id != current_user.id && !is_creator(@class_room)
      flash[:fail] = "You do not have permission to delete that"
      redirect_to root_url
    else
			@subcomment.destroy
			redirect_to :back
		end
  end
end
