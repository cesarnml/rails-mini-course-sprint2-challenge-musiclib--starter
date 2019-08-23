require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "validations" do
    before do
      artist = Artist.create!(name: "Red Hot Chilli Peppers")
    end
    it "is valid" do
      album = Album.create!(name: "Otherside", artist_id: 1)

      result = album.valid?
      errors = album.errors.full_messages

      expect(result).to be(true)
      expect(errors).to be_empty
    end

    it "is invalid without a name" do
      album = Album.new(name: nil)
      result = album.valid?
      errors = album.errors.full_messages

      expect(result).to be false
      expect(errors).to include("Name can't be blank")
    end
  end

  describe "attributes" do
    before do
      artist = Artist.create!(name: "Red Hot Chilli Peppers")
    end
    it "has expected attributes" do
      album = Album.create!(name: "Otherside", artist_id: 1)


      result = album.attribute_names.map(&:to_sym)

      expect(result).to contain_exactly(
        :artist_id,
        :available,
        :created_at,
        :id,
        :name,
        :updated_at
      )
    end
  end

  context "scopes" do
    before do
      artist = Artist.create!(name: "Red Hot Chilli Peppers")
      albums = Album.create!([
          { name: "Otherside", artist_id: 1 },
          { name: "1979", artist_id: 1 },
          { name: "Califorication", artist_id: 1, available: false }
        ])
    end
    describe ".available" do
      it "returns a list of available albums sorted by name" do
        result = Album.available

        expect(result.count).to eq 2
        expect(result.first.name).to eq "1979"
        expect(result.last.name).to eq "Otherside"
        expect(result.any? { |album| album.name == 'Californication'}).to be false
        # set up a some available albums and unavailable albums and make expecations that the
        # available albums scope only returns available albums sorted by name
      end
    end
  end

  describe "#length_seconds" do
    it "calculates the total length in seconds of an album" do
      artist = Artist.create(name: "Red Hot Chilli Peppers")
      album = Album.create(name: "Otherside", artist_id: 1)
      songs = Song.create!([
        { title: "Song A", track_number: 1, length_seconds: 20, album_id: 1 },
        { title: "Song B", track_number: 2, length_seconds: 10, album_id: 1 },
        ])

      result = album.length_seconds

      expect(result).to eq 30
      # setup a valid album and songs and make expecations about the return value of length seconds
    end
  end
end
