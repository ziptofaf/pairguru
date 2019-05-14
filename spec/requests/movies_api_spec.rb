require "rails_helper"

describe "Movies requests", type: :request do
  before(:each) do
    @movie = FactoryBot.create(:movie, title: "SampleMovie")
  end

  describe "movies via original API" do

    it "is possible to see movies list" do
      visit api_movies_path
      response = JSON.parse(page.body)
      expect(response[0]["title"]).to eq "SampleMovie"
    end

    it "is possible to see an individual movie" do
      visit api_movie_path(@movie)
      response = JSON.parse(page.body)
      expect(response["title"]).to eq "SampleMovie"
    end
  end
end
