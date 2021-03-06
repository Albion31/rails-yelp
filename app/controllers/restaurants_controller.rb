require 'pry'

class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all.order("created_at DESC")
  end

  def show
  end

  def new

    @restaurant = current_user.restaurants.build
  end

  def edit
  end

  def create
  @restaurant = current_user.restaurants.build(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render 'edit'
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :user)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
