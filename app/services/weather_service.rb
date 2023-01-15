class WeatherService
    def get_weather(zip)
        key = Rails.application.credentials.weather_api_key
        path = "forecast.json?key=#{key}&q=#{zip}"
        response = Rails.cache.fetch(path, expires_in: 30.seconds) do
            get(path)
        end
        Weather.new(JSON.parse(response.body, symbolize_names: true))
    end
    
    private
    
    def get(path)
        uri = URI('http://api.weatherapi.com/v1/' + path)
        Net::HTTP.get_response(uri)
    end
end