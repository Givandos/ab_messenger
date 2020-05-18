require "test_helper"
require "minitest/mock"

class SmsServiceTest < ActiveSupport::TestCase
  attr_reader :user, :template, :mock

  setup do
    @user = users(:VasyaPupkin)
    @template = message_templates(:confirmation)

    @mock = Minitest::Mock.new
    mock.expect :send_sms, true, [user.phone, template.text]
  end

  test "sends sms with Nexmo (as default)" do
    NexmoService.stub(:new, mock) do
      SmsService.new(user.phone, template.text).send
      assert_mock mock
    end
  end

  test "sends sms with TurboSMS" do
    sms_service = SmsService.new(user.phone, template.text)

    sms_service.stub(:provider, "TurboSMS") do
      TurbosmsService.stub(:new, mock) do
        sms_service.send
        assert_mock mock
      end
    end
  end
end
