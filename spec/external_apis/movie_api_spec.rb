require "rails_helper"
require "fakeweb"
describe Movie do
  context "When using a prerecorded response" do
    it "returns correct response from API when the title exists" do
      body = File.open(Rails.root.join("spec", "external_apis", "responses", "correct.json")).read
      FakeWeb.register_uri(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather",
                           body: body, content_type: "text/html")
      movie = FactoryBot.build(:movie, title: "Godfather")
      expected_response = { title: "Godfather",
                            plot: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
                            rating: 9.2,
                            poster_url: "https://pairguru-api.herokuapp.com/godfather.jpg" }
      expect(movie.api_data).to eq expected_response
    end

    it "returns an empty response from API when the title does not exist" do
      body = File.open(Rails.root.join("spec", "external_apis", "responses", "not_found.json")).read
      FakeWeb.register_uri(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/Invalid",
                           body: body, content_type: "text/html")
      movie = FactoryBot.build(:movie, title: "Invalid")
      expected_response = { title: "Invalid", plot: "Currently unavailable", rating: nil,
                            poster_url: "" }
      expect(movie.api_data).to eq expected_response
    end
  end
end
