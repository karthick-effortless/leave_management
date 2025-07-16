class LeaveRequest < ApplicationRecord
  belongs_to :employee, class_name: "User"
  belongs_to :approver, class_name: "User", optional: true

  has_one_attached :file_url

  validates :start_date, :end_date, :reason, presence: true
  validates :status, inclusion: { in: %w[submitted approved rejected] }
end
