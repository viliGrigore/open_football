# frozen_string_literal: true

class FansController < ApplicationController
  before_action :set_fan, only: %i[show update]

  def index
    @fans = Fan.all
  end

  def show
    head :not_found if @fan.blank?
  end

  def create
    @fan = Fan.new(fan_params)

    if @fan.save
      render :show, status: :created
    else
      handle_error(@fan.errors)
    end
  end

  def update
  if @fan.update(fan_params)
    render :show, status: :created
  else
    handle_error(@fan.errors)
  end
end

  private

  def set_fan
    @fan = Fan.find_by(permitted_params[:id])
  end

  def permitted_params
    params.permit(:id)
  end

  def fan_params
    params.require(:fan).permit(:name,
                                :alcoholic_level,
                                :team_id)
  end
end
