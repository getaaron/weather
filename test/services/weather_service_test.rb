class WeatherServiceTest < ActiveSupport::TestCase
    setup do
        @stub = stub_request(:get, /forecast/)
        .to_return(status: 200, body: weather_forecast_body, headers: {})
        Rails.cache.clear
    end

  test 'should return weather data' do
    weather = WeatherService.new.get_weather(60611)
    assert_requested(@stub, times: 1)
    assert_instance_of Weather, weather
  end

  test 'should cache http data' do
    WeatherService.new.get_weather(60611)
    WeatherService.new.get_weather(60611)
    WeatherService.new.get_weather(60611)
    WeatherService.new.get_weather(60611)
    assert_requested(@stub, times: 1)
  end


  def weather_forecast_body
    File.read('test/fixtures/forecast.json')
  end
end