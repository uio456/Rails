class Candidate < ApplicationRecord
  validates_presence_of :name, :age, :party, :politics
  has_many :vote_logs, dependent: :destroy
end
