class SendMessageService
  attr_reader :message, :user, :message_template, :type, :text

  def initialize(user, message_template, type = :email)
    @user = user
    @message_template = message_template
    @type = type
    @text = prepare_text
  end

  def perform
    save_message
    return message if message.invalid?

    send("send_message_#{message.type}")
    save_send_result

    message
  end

  private

  def save_message
    @message = Message.create(
      user: user,
      message_template: message_template,
      type: type,
      text: text
    )
  end

  def send_message_email
    EmailService.new(user.email, text).send
  end

  def send_message_sms
    SmsService.new(user.phone, text).send
  end

  def save_send_result
    message.update(status: :success)
  end

  def prepare_text
    prepared_text = message_template.text

    replaced = {
      email: user.email,
      phone: user.phone,
      first_name: user.first_name,
      last_name: user.last_name
    }

    replaced.each do |k, v|
      next unless prepared_text.match?("%#{k}%")

      prepared_text.sub!("%#{k}%", v)
    end
    prepared_text
  end
end
