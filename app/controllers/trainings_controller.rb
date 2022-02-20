# frozen_string_literal: true

class TrainingsController < ApplicationController
  def index
    trainings = Training.all
    render json: trainings.to_json
  end

  def show
    training = Training.find_by! id: params[:id]
    render json: training.to_json
  end

  def update; end
end
