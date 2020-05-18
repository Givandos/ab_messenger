class NexmoService
  attr_reader :client, :response

  def initialize
    @client = Nexmo::Client.new(
      api_key: ENV["NEXMO_API_KEY"],
      api_secret: ENV["NEXMO_API_SECRET"]
    )
  end

  def send_sms(to, text)
    @response = client.sms.send(
      from: "Givandos",
      to: prepare_number(to),
      text: text
    )
  end

  private

  def prepare_number(number)
    number = "+#{number}" unless number.match?(/^\+/)

    return number if number.length == 13

    raise ArgumentError, "number should contain 12 digits"
  end
end
