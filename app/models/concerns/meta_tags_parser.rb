require 'mechanize'

#Read recommendation info from metatags
module MetaTagsParser
  def parse
    self.description, self.title, self.image = read_content_from_page('description', 'title', 'image')
  rescue ArgumentError => exception
    Rollbar.error(exception)
  rescue Mechanize::ResponseCodeError => exception
    Rollbar.warning(exception)
  end

  private
    def agent_get!
      agent = Mechanize.new
      agent.get(address)
    end

    def read_content_from_page(*properties)
      page = agent_get!
      properties.collect do |property|
        result = agent_get!.at("meta[property=\"og:#{property}\"]") || {}
        send(property.to_sym) || result[:content]
      end
    end
end
