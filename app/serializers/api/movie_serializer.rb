module Api
  class MovieSerializer < ActiveModel::Serializer
    attributes :id, :title
  end
end
