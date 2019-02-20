class Plan < ApplicationRecord
  validates_presence_of :title
  belongs_to :member
  has_many :comments, :as => :commentable
  
  # Plan 拿到 invite_plan，status: false
  has_many :invite_plans, -> { where status: false }
  # 拿到已送出邀請的 member
  has_many :invited_member, through: :invite_plans, source: :member
  
  # 成立的 plan_member
  has_many :confirm_plans, -> { where status: true }, class_name: "InvitePlan" 
  # 拿到已是成員的 member
  has_many :plan_member, through: :confirm_plans, source: :member



  attr_accessor :tag
  acts_as_taggable_on :tags

  # 已經邀請的 member 
  def invited_member?(member)
    self.invited_member.include?(member)
  end

  # 已經是 plan_member
  def plan_member?(member)
    self.plan_member.include?(member)
  end

end
