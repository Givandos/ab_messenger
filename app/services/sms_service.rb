class SmsService
  LIMIT_LENGTH = true

  attr_reader :phone, :text

  def initialize(phone, text)
    @phone = phone
    @text = text
  end

  def send
    service_name = "#{provider.downcase.capitalize}Service".constantize
    service_name.new.send_sms(phone, prepare_text)
  end

  private

  def prepare_text
    return text unless LIMIT_LENGTH

    # TODO: implement check for cyrillic symbols

    text.truncate(160)
  end

  def provider
    "Nexmo" # or "TurboSMS"
  end
end
