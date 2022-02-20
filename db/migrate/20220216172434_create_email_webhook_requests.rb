class CreateEmailWebhookRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :email_webhook_requests do |t|
      t.json :payload

      t.timestamps
    end
  end
end
