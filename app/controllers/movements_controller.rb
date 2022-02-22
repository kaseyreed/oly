# frozen_string_literal: true

class MovementsController < ApplicationController
  def index
    @movements = Movement.all
  end

  def show
    @movement = Movement.find params[:id]
  end
end
