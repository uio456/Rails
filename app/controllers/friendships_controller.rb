class FriendshipsController < ApplicationController

   def accept
    @friendship = Friendship.where(member_id: params[:member_id], friend_id: current_member.id)
    @friendship.update(status: true)
    flash[:notice] = "確認為好友"
    redirect_back(fallback_location: members_path)
  end

  def ignore
    @friendship = Friendship.where(member_id: params[:member_id], friend_id: current_member.id).first
    @friendship.destroy
    flash[:notice] = "回絕好友邀請"
    redirect_back(fallback_location: members_path)
  end

end
