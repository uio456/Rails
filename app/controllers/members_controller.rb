class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @friendships = Friendship.all
    @all_friends = @member.all_friends
    @friends = @member.friends
    @inverse_friends = @member.inverse_friends
    @waiting_for_accept = @member.waiting_for_accept
    @friends_request = @member.friends_request
  end

  def add_friend
    @friendships = current_member.friendships.build(friend_id: params[:id])

    if @friendships.save
      flash[:notice] = '已送出邀請'
    else
      flash[:alert] = @friendships.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: members_path)
  end
end
