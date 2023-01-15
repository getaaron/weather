# frozen_string_literal: true

class Weather
  attr_reader :id,
              :zip,
              :current_temp,
              :forecast

  def initialize(id, zip, weather_data)
    @id = id
    @zip = zip
    @current_temp = weather_data[:current][:temp_f]
    @forecast = weather_data[:forecast][:forecastday][0][:day][:condition][:text]
  end

  def to_partial_path
    "weather/#{@zip}"
  end
end
