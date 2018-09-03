class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "member_id", dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :member

  has_many :wait_accept_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "member_id", dependent: :destroy
  has_many :waiting_for_accept, through: :wait_accept_friendships, source: :friend
  
  has_many :request_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friends_request, through: :request_friendships, source: :member

  def all_friends
    (friends + inverse_friends).uniq
  end
end
