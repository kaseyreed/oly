# frozen_string_literal: true

class MovementsController < ApplicationController
  def index
    movements = Movement.all
    render json: movements.to_json
  end

  def show
    movement = Movement.find_by! id: params[:id]
    render json: movement.to_json
  end
end
