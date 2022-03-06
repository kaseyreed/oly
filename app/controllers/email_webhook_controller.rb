# frozen_string_literal: true

class EmailWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def handle
    # date = params[:date]
    # subject = params[:subject]
    # text = params[:text]
    # from = params[:from][:value][0][:name]

    request = EmailWebhookRequest.create! payload: params[:email_webhook]
    ProcessEmailWebhookRequestJob.perform_later request_id: request.id
  end
end
