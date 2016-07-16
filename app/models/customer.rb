class Customer < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, uniqueness: true, format: {
             with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
             }

  def to_s
    "#{first_name} #{last_name}"
  end
end
