class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "member_id", dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :member

  has_many :not_accepted_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "member_id", dependent: :destroy
  has_many :not_accepted_friends, through: :not_accepted_friendships, source: :friend
  
  has_many :not_responded_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :not_responded_friends, through: :not_responded_friendships, source: :member
end
