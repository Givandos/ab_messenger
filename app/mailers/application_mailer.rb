class ApplicationMailer < ActionMailer::Base
  attr_reader :template_ids

  default from: -> { "no-reply@example.com" },
          body: "nothing",
          content_type: "text/html"

  def initialize
    @template_ids = Rails.configuration.sendgrid["template_ids"]

    super
  end

  def template_id
    template_ids.dig(action_name)
  end
end
