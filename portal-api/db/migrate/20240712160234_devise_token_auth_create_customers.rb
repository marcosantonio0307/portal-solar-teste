class DeviseTokenAuthCreateCustomers < ActiveRecord::Migration[6.1]
  def change
    
    create_table(:customers) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name, null: false
      t.string :nickname
      t.string :image
      t.string :email, null: false, unique: true

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :customers, :email,                unique: true
    add_index :customers, [:uid, :provider],     unique: true
    add_index :customers, :reset_password_token, unique: true
    add_index :customers, :confirmation_token,   unique: true
    # add_index :customers, :unlock_token,         unique: true
  end
end
