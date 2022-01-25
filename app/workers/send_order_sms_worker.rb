class SendOrderSmsWorker
  include Sidekiq::Worker

  def perform(sms_id)
    record = OrderSmsMessage.find(sms_id)

    record.update!(sent_at: Time.current)
  end
end
