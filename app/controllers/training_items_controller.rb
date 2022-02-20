class TrainingItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

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
