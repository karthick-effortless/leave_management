class LeaveRequestsController < ApplicationController
  before_action :require_login
  before_action :set_leave_request, only: [:show, :edit, :update, :destroy]
  def index
    @leave_requests = current_user.admin? ? LeaveRequest.includes(:employee) : current_user.leave_requests
    @leave_request = LeaveRequest.new
  end
  def new
    @leave_request = LeaveRequest.new
  end

  def show
    # @leave_request = LeaveRequest.find(params[:id])
  end

  def create
    @leave_request = current_user.leave_requests.build(leave_request_params)
    @leave_request.status = "submitted"

    if params[:leave_request][:file_url].present?
      @leave_request.file_url.attach(params[:leave_request][:file_url])
    end

    if @leave_request.save
      redirect_to root_path, notice: "Leave applied"
    else
      render :new
    end
  end

  def edit
    # @leave_request = LeaveRequest.find(params[:id])
  end

  def update
    @leave_request = LeaveRequest.find(params[:id])

    if params[:leave_request][:file_url].present?
      @leave_request.file_url.purge if @leave_request.file_url.attached? # remove old
      @leave_request.file_url.attach(params[:leave_request][:file_url])   # attach new
    end

    if @leave_request.update(leave_request_params.except(:file_url)) # exclude file_url from mass assignment
      redirect_to root_path, notice: "Leave request updated"
    else
      render :edit
    end
  end

  def destroy
    if @leave_request.status == "submitted"
      @leave_request.destroy
      redirect_to root_path, notice: "Deleted successfully"
    else
      redirect_to root_path, alert: "Could not delete leave request"
    end
  end


  def approve
    @leave_request = LeaveRequest.find(params[:id])

    @leave_request.update(
      status: "approved",
      approver_id: params.dig(:leave_request, :approver_id),
      reviewed_at: Time.current,
      comments: params.dig(:leave_request, :comments)
    )

    redirect_to root_path, notice: "Leave approved"
  end


  private

  def set_leave_request
    @leave_request = current_user.leave_requests.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Leave request not found or access denied."  end

  def leave_request_params
    params.require(:leave_request).permit(:start_date, :end_date, :reason, :file_url, :status, :comments, :approver_id, :reviewed_at)
  end
end
