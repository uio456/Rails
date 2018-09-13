class Plan < ApplicationRecord
  validates_presence_of :title
  belongs_to :member
  has_many :comments, :as => :commentable

  attr_accessor :tag
  acts_as_taggable_on :tags
end
