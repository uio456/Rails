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
      # current_member.destroy_friendship!(@member)
      # 有 friends 跟 inverse_friends，另外定義一個方法處理

      # 我家別人 friends
      # friendship = Friendship.where(member_id: current_member.id, friend_id: params[:id]).destroy_all
      # 別人家我 inverse_friendships
      friendship = Friendship.where(member_id: params[:id], friend_id: current_member.id).destroy_all
      flash[:notice] = 'unfriend'
    else
      flash[:alert] = 'unfriend failed'
    end
      redirect_back(fallback_location: root_path)
  end

  def cancelled
    friendship = current_member.wait_accept_friendships.where(friend_id: params[:id], member_id: current_member.id).destroy_all
    flash[:notice] = '取消好友請求'   
    redirect_back(fallback_location: root_path)
  end

   def accept
    # 我是被加的，所以要找出哪個(memebr)加我
    friendship = Friendship.where(member_id: params[:id], friend_id: current_member.id)
    friendship.update(status: true)
    flash[:notice] = "確認為好友"
    redirect_back(fallback_location: members_path)
  end

  def ignore
    # 我是被加的，所以要找出哪個(memebr)加我
    friendship = current_member.request_friendships.where(member_id: params[:id]).destroy_all
    # friendship = Friendship.where(member_id: params[:id], friend_id: current_member.id).destroy_all
    flash[:notice] = "回絕好友邀請"
    redirect_back(fallback_location: members_path)
  end

end
