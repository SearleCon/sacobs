class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @q = City.search(params[:q])
    @cities = @q.result(distinct: true)
  end

  def new
    @city = City.new
  end

  def create
    @city = City.create(city_params)
    respond_with(@city, location: cities_url)
  end

  def update
    @city.update(city_params)
    respond_with(@city, location: cities_url)
  end

  def destroy
    @city.destroy
    respond_with(@city)
  end


  private
    def set_city
      @city = City.friendly.find(params[:id])
    end

    def city_params
      CityParameters.new(params).permit(user: current_user)
    end
end
