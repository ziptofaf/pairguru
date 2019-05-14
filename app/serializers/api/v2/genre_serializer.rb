module Api
  module V2
    class GenreSerializer < ActiveModel::Serializer
      attributes :id, :name, :movies_number

      def movies_number
        object.movies.count
      end

    end
  end
end