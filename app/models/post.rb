class Post < ApplicationRecord
  validates_presence_of :title, :content
  belongs_to :member
end
