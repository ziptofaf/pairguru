module API
  class Movie

    class RecordNotFound < RuntimeError
    end

    class RestClientError < RuntimeError

    end

    attr_reader :title, :plot, :rating, :poster_url

    def initialize(title)
      @title = title
      fetch_from_api
    end

    def to_hash
      { title: @title, plot: @plot, rating: @rating, poster_url: @poster_url }
    end

    private

    def fetch_from_api
      title_to_param = @title.split.join("%20") # needed to handle spacebars
      url = "https://pairguru-api.herokuapp.com/api/v1/movies/#{title_to_param}"
      response = RestClient.get url
      fill_from_api(response)
    rescue RestClient::ExceptionWithResponse => e
      raise RestClientError, e.message
    end

    def fill_from_api(response)
      parsed = JSON.parse(response)
      raise RecordNotFound, parsed["message"] if parsed["message"]
      @plot = parsed["data"]["attributes"]["plot"]
      @rating = parsed["data"]["attributes"]["rating"]
      poster = parsed["data"]["attributes"]["poster"]
      @poster_url = "https://pairguru-api.herokuapp.com#{poster}"
    end
  end
end