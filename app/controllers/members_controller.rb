class MembersController < ApplicationController
  before_action :authenticate_member!
  def index
    @members = Member.all
  end

  def invite
    @plan = Plan.find(params[:plan_id])
    @member = Member.find(params[:member_id])
    # @invite_plan = InvitePlan.new(plan_id: params[:id], member_id: params[:memebr_id])
    @invite = @member.invite.create(plan: @plan)

    if @invite.save
      flash[:notice] = "邀請 #{params[:member_id]} 加入"
      redirect_to plan_path(@plan)
    else
      flash[:alert] = @invite.errors.full_messages.to_sentence
      redirect_back(fallback_location: plans_path)
    end
  end

   def cancelled
    @plan = Plan.find(params[:id])
    @confirm = InvitePlan.where(plan_id: params[:id], member_id: current_member).first
    @confirm.destroy
    flash[:notice] = "刪除邀請"
    redirect_back(fallback_location: @plan)
  end

  def show
    @member = Member.find(params[:id])
    @friendships = Friendship.all
    @all_friends = @member.all_friends
    @friends = @member.friends
    @inverse_friends = @member.inverse_friends
    @waiting_for_accept = @member.waiting_for_accept
    @friends_request = @member.friends_request
    @invited_plans = @member.invited_plans.all
  end

  # def add_friend
  #   @friendship = current_member.friendships.build(friend_id: params[:id], status: false)

  #   if @friendship.save
  #     flash[:notice] = '已送出邀請'
  #   else
  #     flash[:alert] = @friendship.errors.full_messages.to_sentence
  #   end
  #   redirect_back(fallback_location: members_path)
  # end

  # def unfriend
  #   @member = Member.find(params[:id])
  #   if current_member.friends?(@member)
  #     current_member.destroy_friendship!(@member)
  #     flash[:notice] = 'unfriend'
  #   else
  #     flash[:alert] = 'unfriend failed'
  #   end
  #     redirect_back(fallback_location: root_path)
  # end

  # def accept
  #   @firendship = current_member.friends_request.where(member_id: params[:id])
  #   @friendship.update(status: true)
  #   false[:notice] = "確認為好友"
  # end

  def drafts
    @drafts = current_member.posts.where(public: false)
  end

  def change_role
    # 因為在前台所以多開一個 action 更換權限，update 留給更新 Profile
    # 如果在後台可以直接用update action 就好，
    @member = Member.find(params[:id])
    if @member.email == "admin@example.com"
      flash[:alert] = "不要動！這個帳號是管理員"
      redirect_to members_path
    else
      @member.update(member_params)
      flash[:notice] = "#{@member.name}權限更新為 #{@member.role}"
      redirect_to members_path
    end
  end
  private

  def member_params
    params.require(:member).permit(:role)
  end
end
