class CreateLeaveRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_requests, id: :uuid do |t|
      t.references :employee, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.date :start_date
      t.date :end_date
      t.text :reason
      t.string :file_url
      t.string :status

      t.timestamps
    end
  end
end
