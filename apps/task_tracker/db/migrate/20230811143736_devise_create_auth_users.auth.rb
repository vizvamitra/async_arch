# frozen_string_literal: true

# This migration comes from auth (originally 20230811091313)
class DeviseCreateAuthUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :auth_users do |t|
      t.string :email, null: false, default: ""
      t.integer :role, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false

      ## Database authenticatable
      # t.string :email,              null: false, default: ""
      # t.string :encrypted_password, null: false, default: ""

      ## OAuth2
      t.string :provider, limit: 50,  default: ''
      t.string :uid,      limit: 500, default: ''
      t.string :doorkeeper_access_token
      t.string :doorkeeper_refresh_token
      t.datetime :doorkeeper_expires_at

      ## Recoverable
      # t.string   :reset_password_token
      # t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :auth_users, :email,             unique: true
    add_index :auth_users, %i[provider uid],   unique: true
    # add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
