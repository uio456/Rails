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
    @waiting_for_accept = @member.waiting_for_accept
    @request_friends = @member.request_friends
  end
end
