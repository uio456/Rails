class User < ApplicationRecord
  has_one :store
  # validates :user_id, uniqueness: { scope: :votes }
end
