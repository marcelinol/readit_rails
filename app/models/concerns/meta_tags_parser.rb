require 'mechanize'

#Read recommendation info from metatags
module MetaTagsParser
  def parse
    @page = agent_get!(address)
    description = read_content_from_page('description')
    title ||= read_content_from_page('title')
    image = read_content_from_page('image')
  rescue ArgumentError => exception
    puts exception.freeze #log this?
  end

  private
    def agent_get!(url)
      agent = Mechanize.new
      agent.get(url)
    end

    def read_content_from_page(property)
      result = @page.at("meta[property=\"og:#{property}\"]") || {}
      result[:content]
    end
end
