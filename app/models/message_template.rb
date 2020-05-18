class MessageTemplate < ApplicationRecord
  has_many :messages

  validates :name, :text,
            presence: true

  validates :name,
            uniqueness: true
end
