LeaveRequestReview.delete_all
LeaveRequest.delete_all
User.delete_all

admin1 = User.create!(name: "karthi", email: "karthi@company.com", password: "password", role: "admin")


emp1 = User.create!(name: "surya", email: "surya@company.com", password: "password", role: "employee")
emp2 = User.create!(name: "ajith", email: "ajith@company.com", password: "password", role: "employee")
emp3 = User.create!(name: "cheems", email: "cheems@company.com", password: "password", role: "employee")


leave1 = LeaveRequest.create!(
  employee: emp1,
  start_date: Date.today + 1,
  end_date: Date.today + 5,
  reason: "Vacation",
  status: "submitted"
)

leave2 = LeaveRequest.create!(
  employee: emp1,
  start_date: Date.today + 10,
  end_date: Date.today + 12,
  reason: "Medical",
  status: "approved"
)

leave3 = LeaveRequest.create!(
  employee: emp2,
  start_date: Date.today + 3,
  end_date: Date.today + 4,
  reason: "Personal work",
  status: "rejected"
)

leave4 = LeaveRequest.create!(
  employee: emp3,
  start_date: Date.today + 7,
  end_date: Date.today + 9,
  reason: "Conference",
  status: "submitted"
)

LeaveRequestReview.create!(
  leave_request: leave2,
  approver: admin1,
  status: "approved",
  comments: "Enjoy your leave",
  reviewed_at: Time.current
)

LeaveRequestReview.create!(
  leave_request: leave3,
  approver: admin1,
  status: "rejected",
  comments: "Insufficient leave balance",
  reviewed_at: Time.current
)


puts "Seeds created: 2 admins, 3 employees, 4 leave requests, 2 reviews"