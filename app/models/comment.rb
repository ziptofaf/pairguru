class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validate :only_one_per_movie_and_user

  private

  def only_one_per_movie_and_user
    if Comment.exists?(movie: movie, user: user)
      errors.add(:user, "has already added a comment to this movie")
    end
  end

end
