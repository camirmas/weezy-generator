module WeezyHelper
  class Artist
    attr_reader :noko_doc

    def initialize(link)
      doc = RestClient.get(link)
      @noko_doc = Nokogiri::HTML(doc)
    end

    def extract_links
      links = []

      noko_doc.css("div#listAlbum > a").each do |item|
        links << "http://azlyrics.com/#{item.attr("href")}"
      end

      links
    end
  end
end
