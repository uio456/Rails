class CandidatesController < ApplicationController

  def index
    @candidates = Candidate.all

    if params[:id]
      @candidate= Candidate.find(params[:id])
    else
      @candidate = Candidate.new
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

    if @candidate.save
      flash[:notice] = "更新成功"
    else
      flash[:alert] = @candidate.errors.fall_messages.to_sentence
    end
    redirect_to root_path
  end

  private

  def params_candidate
    params.require(:candidate).permit(:name, :age, :politics, :party, :votes)
  end

end
