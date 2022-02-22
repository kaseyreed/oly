# frozen_string_literal: true

class TrainingsController < ApplicationController
  def index
    @trainings = Training.includes(training_items: :movements).all
  end

  def show
    @training = Training.includes(training_items: :movements).find(params[:id])
  end

  def update; end
end
