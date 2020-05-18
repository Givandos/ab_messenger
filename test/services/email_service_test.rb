require "test_helper"
require "minitest/mock"

class EmailServiceTest < ActiveSupport::TestCase
  attr_reader :user, :template

  setup do
    @user = users(:VasyaPupkin)
    @template = message_templates(:confirmation)
  end

  test "sends email" do
    delivery = Minitest::Mock.new
    delivery.expect :deliver_now, nil, []

    MainMailer.stub(:main, delivery) do
      EmailService.new(user.email, template.text).send
      assert_mock delivery
    end
  end
end
