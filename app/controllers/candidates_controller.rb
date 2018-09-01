class CandidatesController < ApplicationController

  def index
    @candidates = Candidate.all
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(params_candidate)

    if @candidate.save
      flash[:notice] = "建立成功"
    else
      flash[:alert] = "建立有誤"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def params_candidate
    params.require(:candidate).permit(:name, :age, :politics, :party, :votes)
  end

end
