class Recommendation < ApplicationRecord
  validates_presence_of :address, :title
end
