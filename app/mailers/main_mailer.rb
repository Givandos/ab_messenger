class MainMailer < ApplicationMailer
  def main(email, text)
    mail(
      to: email,
      template_id: template_id,
      dynamic_template_data: {
        text: text
      }
    )
  end
end
