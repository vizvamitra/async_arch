class CreatePaymentCycles < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_cycles do |t|
      t.references :employee, null: false, index: false
      t.boolean :closed, null: false, default: false
      t.datetime :closed_at
      t.date :date, null: false

      t.timestamps

      t.index %i[employee_id date], unique: true
      t.index %i[employee_id closed], unique: true, where: "closed IS FALSE"
    end
  end
end
