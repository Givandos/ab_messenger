class TurbosmsService
  API_URL = "https://api.turbosms.ua/message/send.json".freeze

  attr_reader :client, :response

  def send_sms(to, text)
    uri = URI(API_URL)
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV['TURBOSMS_API_KEY']}"
    }
    req = Net::HTTP::Post.new(uri, headers)
    req.body = request_body(to, text).to_json
    @response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end

  private

  def request_body(to, text)
    {
      recipients: [prepare_number(to)],
      sms: {
        sender: "TestSender",
        text: text
      }
    }
  end

  def prepare_number(number)
    number = "+#{number}" unless number.match?(/^\+/)

    return number if number.length == 13

    raise ArgumentError, "number should contain 12 digits"
  end
end
