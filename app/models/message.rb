# frozen_string_literal: true
class Message < ApplicationRecord
  self.inheritance_column = :_type_disabled

  REPEAT_FREQUENCY_MINUTES = 5

  belongs_to :user
  belongs_to :message_template

  validates :user, :message_template, :type, :status,
            presence: true

  validates :type,
            inclusion: { in: %w(email sms),
                         message: "%{value} is not a valid message type" }

  validates :status,
            inclusion: { in: %w(pending success),
                         message: "%{value} is not a valid message status" }

  validates :user,
            uniqueness: true,
            if: lambda {
              Message.exists?(
                "created_at >= #{Time.current - REPEAT_FREQUENCY_MINUTES.minutes}"
              )
            }
end
