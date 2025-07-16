class User < ApplicationRecord
  has_secure_password

  has_many :leave_requests, foreign_key: :employee_id

  enum :role, { employee: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true
end
