require "test_helper"
require "minitest/mock"

class SendMessageServiceTest < ActiveSupport::TestCase
  attr_reader :user, :template, :mock

  setup do
    @user = users(:VasyaPupkin)
    @template = message_templates(:confirmation)

    @mock = Minitest::Mock.new
    mock.expect :send, true
  end

  test "creates message when sends it" do
    stubbed_email_service do
      service = SendMessageService.new(user, template)

      assert_difference "Message.count", 1 do
        service.perform
      end
    end
  end

  test "returns message" do
    stubbed_email_service do
      message = SendMessageService.new(user, template).perform

      assert_equal Message.new.class, message.class
    end
  end

  test "sends email as default" do
    stubbed_email_service do
      message = SendMessageService.new(user, template).perform

      assert_mock mock
      assert_equal "email", message.type
    end
  end

  test "sends SMS" do
    stubbed_sms_service do
      message = SendMessageService.new(user, template, :sms).perform
      assert_mock mock
      assert_equal "sms", message.type
    end
  end

  test "puts pretty result" do
    stubbed_email_service do
      service = SendMessageService.new(user, template)

      assert_output /user\ number/ do
        service.perform
      end
    end
  end

  def stubbed_email_service
    EmailService.stub(:new, mock) do
      yield if block_given?
    end
  end

  def stubbed_sms_service
    SmsService.stub(:new, mock) do
      yield if block_given?
    end
  end
end
