class AddPublicIdToEmployees < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'
    add_column :employees, :public_id, :uuid, null: false, default: "uuid_generate_v4()"
  end
end
