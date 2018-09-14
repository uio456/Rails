class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :plans
  has_many :posts, dependent: :destroy
  
  has_many :comments
  has_many :comments_post, through: :comments, source: :post

  has_many :invite_plans
  

  # Friendship 的資料表紀錄，menber 是送出邀請的人，friend_id 是被邀請的人。

  # member_id如果是自己，就會去拿 friend_id，並且status 要是 true，的用戶出來
  has_many :friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "member_id", dependent: :destroy
  has_many :friends, through: :friendships
  
  # 從friend_id 如果是自己，就會去拿 member_id出來，並且status 要是 true，的用戶出來
  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :member

  # 使用 wait_accept_friendships 送出 create 好友邀請。
  # member_id 如果是自己，就去拿 friend_id，並且status 要是 false，的用戶出來
  has_many :wait_accept_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "member_id", dependent: :destroy
  has_many :waiting_for_accept, through: :wait_accept_friendships, source: :friend
  
  # friend_id 如果是自己，就會去拿 member_id出來，並且status 要是 false，的用戶出來
  has_many :request_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friends_request, through: :request_friendships, source: :member

  def all_friends
    (friends + inverse_friends).uniq
  end

  def waiting_for_accept?(member)
    self.waiting_for_accept.include?(member)
  end

  def friends_request?(member)
    self.friends_request.include?(member)
  end

  def friends?(member)
    self.friends.include?(member) || self.inverse_friends.include?(member)
  end

  def destroy_friendship!(member)
    ActiveRecord::Base.transaction do
      self.friendships.where(friend_id: member.id).destroy_all
      self.inverse_friendships.where(member_id: member.id).destroy_all
      # self.wait_accept_friendships.where(friend_id: member.id).destroy_all
    end
  end
end
