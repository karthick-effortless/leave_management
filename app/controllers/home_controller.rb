class HomeController < ApplicationController
  before_action :require_login
  def index
    @leave_requests = current_user.admin? ? LeaveRequest.includes(:employee) : current_user.leave_requests
  end
end
