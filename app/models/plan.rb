class Plan < ApplicationRecord
  validates_presence_of :title
  belongs_to :member
  has_many :comments, :as => :commentable
  
  # Plan 拿到 invite_plan，status: false
  has_many :invite_plans, -> { where status: false }

  has_many :confirm_plans, -> { where status: true }, class_name: "InvitePlan"
  has_many :plan_member, through: :confirm_plans, source: :member

  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :member

  attr_accessor :tag
  acts_as_taggable_on :tags

  # 確認計畫
  def confirm_plans?(memebr)
    self.confirm_plans.include?(member)
  end

  def invited_member?(member)
    self.invite_plans.include?(member)
  end
end
