class Post < ApplicationRecord
  validates_presence_of :title, :content
  belongs_to :member
  has_many :comments, :as => :commentable

  # attr_accessor :tag_list
  acts_as_taggable_on :tags
end
