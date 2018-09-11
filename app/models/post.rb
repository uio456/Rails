class Post < ApplicationRecord
  validates_presence_of :title, :content
  belongs_to :member
  # attr_accessor :tag_list
  acts_as_taggable_on :tags
end
