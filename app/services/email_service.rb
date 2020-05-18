class EmailService
  attr_reader :email, :text

  def initialize(email, text)
    @email = email
    @text = text
  end

  def send
    MainMailer.main(email, text).deliver_now
  end
end
