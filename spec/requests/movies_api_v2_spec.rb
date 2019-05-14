require "rails_helper"

describe "Movies requests", type: :request do
  before(:each) do
    @movie = FactoryBot.create(:movie, title: "SampleMovie")
  end

  describe "movies via V2 API" do
    it "is possible to see movies list" do
      visit api_v2_movies_path
      response = JSON.parse(page.body)
      expect(response[0]["title"]).to eq "SampleMovie"
    end

    it "is possible to see an individual movie" do
      visit api_v2_movie_path(@movie)
      response = JSON.parse(page.body)
      expect(response["title"]).to eq "SampleMovie"
      expect(response["genre"]["movies_number"]).to eq 1
    end
  end
end
