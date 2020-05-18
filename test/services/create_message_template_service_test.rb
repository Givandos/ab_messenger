require "test_helper"

class CreatMessageTemplateServiceTest < ActiveSupport::TestCase
  test "creates message template" do
    service = CreateMessageTemplateService.new("test_name", "Test text")

    assert_difference "MessageTemplate.count", 1 do
      service.perform
    end
  end

  test "don't creates message template with invalid params" do
    service = CreateMessageTemplateService.new("test_name", nil)

    assert_no_difference "MessageTemplate.count" do
      service.perform
    end
  end
end
