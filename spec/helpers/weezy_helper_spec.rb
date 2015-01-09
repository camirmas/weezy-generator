require 'rails_helper'

describe WeezyHelper do
  let(:artist) { WeezyHelper::Artist.new("http://www.azlyrics.com/l/lilwayne.html") }

  context "on initialization" do
    it "creates a noko document given a URL" do
      expect(artist.noko_doc.class).to eq(Nokogiri::HTML::Document)
    end
  end

  describe "#extract links" do
    it "returns the URLs of all of the songs on the page" do
      result = artist.extract_links

      expect(result).to include("http://azlyrics.com/../lyrics/lilwayne/highbeamin.html")
    end
  end
end
