require "test_helper"
require "minitest/mock"

class ApplicationMailerTest < ActiveSupport::TestCase
  attr_reader :mailer

  setup do
    Rails.configuration.sendgrid[:template_ids].merge!(
      test_mailer_action_name: 'test_template_id'
    )
    @mailer = ApplicationMailer.new
  end

  test 'template_id returns correct id' do
    mailer.stub :action_name, 'test_mailer_action_name' do
      assert_equal 'test_template_id', mailer.template_id
    end
  end

  test 'template_id returns nil if id missing in config list' do
    mailer.stub :action_name, 'missing_mailer_action_name' do
      assert_nil mailer.template_id
    end
  end
end
