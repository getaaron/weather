class WeatherController < ApplicationController
  def index
    # nothing to do here since this just shows the form
  end

  def create
    weather = WeatherService.instance.get_weather(zip)
    redirect_to weather_path(weather.id)
  end

  def show
    @weather = WeatherService.instance.get_recent(id)
  end

  private
    def id
      params.require(:id)
    end

    def zip
      params.require(:zip)
    end
end