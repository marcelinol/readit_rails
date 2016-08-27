# :nodoc:
class Article < Recommendation
  validates :address, format: {
    with: URI::regexp,
    message: 'The address is invalid'
  }
end
