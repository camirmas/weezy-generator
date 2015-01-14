module WeezyHelper
  class Artist
    attr_reader :noko_doc

    def initialize(link)
      @noko_doc = Nokogiri::HTML(RestClient.get(link, user_agent: "Chrome"))
    end

    def extract_links
      links = []

      noko_doc.css("div#listAlbum > a").each do |item|
        links << "http://azlyrics.com/#{item.attr("href")[3..-1]}"
      end

      links
    end
  end

  class Song
    attr_reader :song_doc

    def initialize(link)
      @song_doc = Nokogiri::HTML(RestClient.get(link, user_agent: "Chrome"))
    end

    def lyrics
      items = []
      items << song_doc.css("div#main b")
      if song_doc.css("span.feat")
        items << song_doc.css("span.feat")
      end
      items << song_doc.css("div[style='margin-left:10px;margin-right:10px;']")
      return items
    end
  end
end
