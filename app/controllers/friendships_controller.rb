class FriendshipsController < ApplicationController

   def accept
    @friendship = Friendship.where(member_id: params[:member_id], friend_id:current_member.id)
    @friendship.update(status: true)
    flash[:notice] = "確認為好友"
    redirect_back(fallback_location: members_path)
  end

end
