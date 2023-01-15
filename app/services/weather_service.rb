# frozen_string_literal: true

require 'securerandom'
require 'singleton'

class WeatherService
  include Singleton

  def get_weather(zip)
    key = Rails.application.credentials.weather_api_key
    path = "forecast.json?key=#{key}&q=#{zip}"
    Rails.cache.fetch(path, expires_in: 30.minutes) do
      response = get(path)
      id = SecureRandom.uuid
      weather = Weather.new(id, zip, JSON.parse(response.body, symbolize_names: true))
      recents[id] = weather
      weather
    end
  end

  def get_recent(id)
    recents[id]
  end

  private

  def get(path)
    uri = URI("http://api.weatherapi.com/v1/#{path}")
    Net::HTTP.get_response(uri)
  end

  def recents
    @recents ||= {}
  end
end
