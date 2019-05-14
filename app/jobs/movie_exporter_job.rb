class MovieExporterJob < ApplicationJob
  queue_as :default

  def perform(user)
    require 'securerandom'
    random_string = SecureRandom.hex
    # needed because we are dealing with multithreading
    file_path = "tmp/#{random_string}.csv"
    MovieExporter.new.call(user, file_path)
  end
end
