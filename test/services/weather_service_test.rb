# frozen_string_literal: true

class WeatherServiceTest < ActiveSupport::TestCase
  setup do
    @stub = stub_request(:get, /forecast/)
            .to_return(status: 200, body: weather_forecast_body, headers: {})
    Rails.cache.clear
  end

  test 'should return weather data' do
    weather = WeatherService.instance.get_weather(60611)
    assert_requested(@stub, times: 1)
    assert_instance_of Weather, weather
  end

  test 'should cache http data' do
    a = WeatherService.instance.get_weather(60611)
    b = WeatherService.instance.get_weather(60611)
    c = WeatherService.instance.get_weather(60611)
    d = WeatherService.instance.get_weather(60611)
    assert_requested(@stub, times: 1)
    assert_equal(a.created_at, b.created_at)
    assert_equal(c.created_at, b.created_at)
    assert_equal(d.created_at, b.created_at)
  end

  def weather_forecast_body
    File.read('test/fixtures/forecast.json')
  end
end
