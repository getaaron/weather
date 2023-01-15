# frozen_string_literal: true

class WeatherController < ApplicationController
  include ActionView::Helpers::DateHelper

  def index
    # nothing to do here since this just shows the form
  end

  def create
    weather = WeatherService.instance.get_weather(zip)
    redirect_to weather_path(weather.id)
  end

  def show
    @weather = WeatherService.instance.get_recent(id)
    redirect_to weather_index_path and return unless @weather.present?

    @time_ago = distance_of_time_in_words(@weather.created_at, Time.now, include_seconds: true)
  end

  private

  def id
    params.require(:id)
  end

  def zip
    params.require(:zip)
  end
end
