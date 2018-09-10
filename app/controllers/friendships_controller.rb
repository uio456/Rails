class FriendshipsController < ApplicationController

  def create
    @friendship = current_member.friendships.create(friend_id: params[:friend_id], status: false)
    # @friendship = Friendship.create(friend_id: params[:friend_id], member: current_member)

    if @friendship.save
      flash[:notice] = "送出好友邀請！"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: members_path)  
  end

  def destroy
    @member = Member.find(params[:id])
    if current_member.friends?(@member)
      current_member.destroy_friendship!(@member)
      # 有 friends 跟 inverse_friends 差別另外定義一個方法處理

      # 我家別人 friends
      # friendship = Friendship.where(friend_id: params[:id], member_id: current_member.id).destroy_all
      # 別人家我 inverse_friendships
      # friendship = Friendship.where(member_id: params[:id], friend_id: current_member.id).destroy_all
      flash[:notice] = 'unfriend'
    elsif 
      friendship = current_member.wait_accept_friendships.where(friend_id: params[:id])
      friendship.destroy_all
      # current_member.destroy_friendship!(@member)
      flash[:notice] = '取消好友請求'
        
    else
      flash[:alert] = 'unfriend failed'
    end
      redirect_back(fallback_location: root_path)
  end

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
