class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @friendships = Friendship.all
    @all_friends = @member.all_friends
    @friends = @member.friends
    @inverse_friends = @member.inverse_friends
    @not_accepted_friends = @member.not_accepted_friends
    @not_responded_friends = @member.not_responded_friends
  end
end
