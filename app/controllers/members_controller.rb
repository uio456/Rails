class MembersController < ApplicationController
  before_action :authenticate_member!
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
    @friendship = current_member.friendships.build(friend_id: params[:id], status: false)

    if @friendship.save
      flash[:notice] = '已送出邀請'
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: members_path)
  end

  def unfriend
    @friendship = current_member.friendships.where(friend_id: params[:id])
    @friendship.destroy_all
    redirect_to member_path(current_member), alert: "已收回好友要求"
  end

  def accept
    @firendship = current_member.friends_request.where(member_id: params[:id])
    @friendship.update(status: true)
    false[:notice] = "確認為好友"
  end

  def drafts
    @drafts = current_member.posts.where(public: false)
  end
end
