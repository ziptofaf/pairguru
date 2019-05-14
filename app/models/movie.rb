# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre

  def api_data
    begin
      @api_data ||= API::Movie.new(title).to_hash
    rescue API::Movie::RecordNotFound, API::Movie::RestClientError
      @api_data ||= { title: title, plot: "Currently unavailable", rating: nil, poster_url: "" }
    end
    @api_data
  end

end
