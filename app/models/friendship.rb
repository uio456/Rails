class Friendship < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: "Member"
  validates :friend_id, uniqueness: { scope: :member_id }
end
