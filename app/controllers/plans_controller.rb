class PlansController < ApplicationController

  def index
    @plans = Plan.all
    @members = Member.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.member = current_member
    if @plan.save
      flash[:notice] = "建立計畫 "
      redirect_to plans_path
    else
      flash[:alert] = @plan.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @comment = Comment.new
    @members = Member.all
    @invite_plans = InvitePlan.all
  end

  def invite
    @plan = Plan.find(params[:id])
    @user = User.find(params[])
    # @invite_plan = InvitePlan.new(plan_id: params[:id], member_id: params[:memebr_id])
    @invite_plan = @user.invite_plans.create(plan_id: @plan.id)

    if @invite_plan.save
      flash[:notice] = "邀請 #{member_id} 加入}"
      redirect_to plan_path(@plan)
    else
      flash[:alert] = @invite_plan.errors.full_messages.to_sentence
      redirect_to plan_path(@plan)
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :image, :tag_list)
  end

end
