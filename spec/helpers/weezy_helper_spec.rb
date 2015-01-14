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

      expect(result).to include("http://azlyrics.com/lyrics/lilwayne/highbeamin.html")
    end
  end

  describe "Song" do
    let(:song) { WeezyHelper::Song.new(artist.extract_links.first) }

    context "on initialization" do
      it "creates a Noko instance out of a link" do
        expect(song.song_doc.class).to eq(Nokogiri::HTML::Document)
      end
    end

    describe "#lyrics" do
      it "returns an array" do
        expect(song.lyrics.class).to eq(Array)
      end

      it "has the title as the first array value" do
        expect(song.lyrics.first.text).to eq("\"High Beamin\"")
      end

      it "has the feat. as the second array value" do
        expect(song.lyrics[1].text).to eq("(feat. BG)")
      end

      it "has the lyrics as the last array value" do
        expect(song.lyrics.last.text).to include("Mercedes")
      end
    end
  end
end
