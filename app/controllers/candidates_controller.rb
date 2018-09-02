class CandidatesController < ApplicationController
  before_action :authenticate_member!

  def index
    @candidates = Candidate.all

    if params[:id]
      @candidate= Candidate.find(params[:id])
    else
      @candidate = Candidate.new
    end
  end

  def show
    @candidate = Candidate.find(params[:id])
    @candidate.increment(:view)
    @candidate.save
  end

  def vote
    @candidate = Candidate.find(params[:id])
    @candidate.vote_logs.create!(ip_address: request.remote_ip)
    if @candidate.save
      redirect_to candidates_path, notice: "完成投票！"
    else
      @candidate.errors.fall_messages.to_sentence
      redirect_to candidates_path
    end
  end

  def create
    @candidate = Candidate.new(params_candidate)

    if @candidate.save
      flash[:notice] = "建立成功"
    else
      flash[:alert] = @candidate.errors.fall_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @candidate = Candidate.find(params[:id])
    @candidate.update(params_candidate)
    # 此為測試功能，當候選人更新成功會加10票，(可以用來做瀏覽數量)
    @candidate.votes = @candidate.votes+10
    if @candidate.save
      flash[:notice] = "更新成功"
    else
      flash[:alert] = @candidate.errors.fall_messages.to_sentence
    end
    redirect_to root_path
  end

  def destroy
    @candidate = Candidate.find(params[:id])
    @candidate.destroy
    flash[:alert] = "asd"
    redirect_back(fallback_location: root_path)
  end

  private

  def params_candidate
    params.require(:candidate).permit(:name, :age, :politics, :party, :votes)
  end

end
