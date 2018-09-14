class InvitePlan < ApplicationRecord
  belongs_to :member
  belongs_to :plan
end
