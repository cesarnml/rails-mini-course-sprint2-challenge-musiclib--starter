require 'rails_helper'

RSpec.describe "Get Album", type: :request do
  describe "GET /api/v1/albums/:id" do
    let(:artist) { Artist.create!(name: "Red Hot Chilli Peppers") }

    let(:album) {
      # set up an album to get
      Album.create!(name: "Otherside", artist_id: artist.id)
    }

    it "gets the album" do
      valid_params = { id: album.id }
      get "/api/v1/albums", params: valid_params
      json_body = JSON.parse(response.body).deep_symbolize_keys
      puts response.body, 'hello'
      # write an expectation about the response status code
      expect(json_body).to have_http_status(200)
      # write an expecation about the response json_body
      expect(json_body).to include({
        name: "Otherside",
      })
    end
  end
end
