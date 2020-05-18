class User < ApplicationRecord
  has_many :messages

  validates :email,
            format: { with: /\A[\w.-]+@[\w.-]+\.[\w.-]+\z/ }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
end
