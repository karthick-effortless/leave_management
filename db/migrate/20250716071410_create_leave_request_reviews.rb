class CreateLeaveRequestReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_request_reviews, id: :uuid do |t|
      t.references :leave_request, null: false, foreign_key: true, type: :uuid
      t.references :approver, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.string :status
      t.datetime :reviewed_at
      t.text :comments

      t.timestamps
    end
  end
end
