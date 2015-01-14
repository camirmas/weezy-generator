class WeezyController < ApplicationController
  helper WeezyHelper

  def show
    artist = WeezyHelper::Artist.new("http://www.azlyrics.com/l/lilwayne.html")
    links = artist.extract_links
    @song = WeezyHelper::Song.new(links.sample)

    while !@song && !links.empty?
      @song = WeezyHelper::Song.new(links.sample)
    end
  end
end
