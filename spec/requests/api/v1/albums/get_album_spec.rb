require 'rails_helper'

RSpec.describe "Get Album", type: :request do
  describe "GET /api/v1/albums/:id" do

    let(:album) {
      # set up an album to get
      { album: {id: 1}}
    }

    it "gets the album" do
      get api_v1_album_path(album)
      json_body = JSON.parse(response.body).deep_symbolize_keys

      # write an expectation about the response status code
      # write an expecation about the response json_body
    end
  end
end
