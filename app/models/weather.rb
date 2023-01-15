class Weather
    attr_reader :current_temp,
                :forecast
    
    def initialize(weather_data)
        @current_temp = weather_data[:current][:temp_f]
        @forecast = weather_data[:forecast][:forecastday][0][:day][:condition][:text]
    end
end