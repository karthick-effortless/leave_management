class MoveReviewFieldsToLeaveRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :leave_requests, :approver_id, :uuid
    add_column :leave_requests, :reviewed_at, :datetime
    add_column :leave_requests, :comments, :text

    add_index :leave_requests, :approver_id
    add_foreign_key :leave_requests, :users, column: :approver_id

    drop_table :leave_request_reviews
  end
end
