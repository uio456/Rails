class Plan < ApplicationRecord
  validates_presence_of :title
  belongs_to :member
  attr_accessor :tag
  acts_as_taggable_on :tags
end
