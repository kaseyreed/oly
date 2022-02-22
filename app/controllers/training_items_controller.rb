class TrainingItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @training_item = TrainingItem.includes(:movements).find(params[:id])
  end

  def update
    p 'results???'
    p params
    p params['results']

    training_item_id = params[:id]

    training_item = TrainingItem.find_by! id: training_item_id

    render json: {
      training_item_id:,
    }.to_json
  end
end
