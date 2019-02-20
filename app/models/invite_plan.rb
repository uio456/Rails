class InvitePlan < ApplicationRecord
  # validates :member_id, uniqueness: { scope: :plan_id }

  belongs_to :member
  belongs_to :plan
end
