class Candidate < ApplicationRecord
  validates_presence_of :name, :age, :party, :politics
end
