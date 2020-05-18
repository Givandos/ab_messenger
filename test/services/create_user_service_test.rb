require "test_helper"

class CreatUserServiceTest < ActiveSupport::TestCase
  attr_reader :params

  setup do
    @params = {
      email: "test@exmple.com",
      phone: "380994443322",
      first_name: "James",
      last_name: "Bond"
    }
  end

  test "creates user" do
    service = CreateUserService.new(params)

    assert_difference "User.count", 1 do
      service.perform
    end
  end

  test "don't creates user with invalid params" do
    params[:email] = "invalid_email"
    service = CreateUserService.new(params)

    assert_no_difference "User.count" do
      service.perform
    end
  end
end
