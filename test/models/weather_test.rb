require 'test_helper'

class WeatherTest < ActiveSupport::TestCase
  test "it initializes from weatherapi input" do
    input = {current: {temp_f: 50}, forecast: {forecastday: [{day: {condition: {text: "Sunny"}}}]}}
    weather = Weather.new(input)
    assert_instance_of Weather, weather
    assert_equal 50, weather.current_temp
    assert_equal "Sunny", weather.forecast
  end
end