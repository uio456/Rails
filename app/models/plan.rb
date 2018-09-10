class Plan < ApplicationRecord
  validates_presence_of :title
  belongs_to :member
end
