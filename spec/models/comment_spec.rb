require "rails_helper"

RSpec.describe Comment, type: :model do
  it "is not possible to add two comments to same movie by same user" do
    movie = FactoryBot.create(:movie)
    user = FactoryBot.create(:user)
    comment1 = FactoryBot.build(:comment, user: user, movie: movie)
    comment1.save
    expect(comment1.new_record?).to eq false
    comment2 = FactoryBot.build(:comment, user: user, movie: movie)
    comment2.save
    expect(comment2.new_record?).to eq true
    expect(comment2.errors.messages[:user]).to eq ["has already added a comment to this movie"]
  end
end
