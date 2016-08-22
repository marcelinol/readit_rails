# This should be used as an abstract class
class Recommendation < ApplicationRecord
  validates :address, presence: true
  validates :title, presence: true
end
