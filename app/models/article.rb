# :nodoc:
class Article < Recommendation
  validates :address, format: {
    with: URI::regexp,
    message: 'has invalid format'
  }
end
