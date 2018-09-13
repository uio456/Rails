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
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :image, :tag_list)
  end

end
