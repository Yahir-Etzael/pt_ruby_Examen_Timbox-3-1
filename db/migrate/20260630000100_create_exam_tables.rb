class CreateExamTables < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :rfc, null: false
      t.string :password_digest, null: false
      t.string :session_token
      t.boolean :admin, null: false, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :rfc, unique: true
    add_index :users, :session_token

    create_table :collaborators do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.text :rfc
      t.text :fiscal_address
      t.text :curp
      t.text :nss
      t.date :start_date, null: false
      t.string :contract_type, null: false
      t.string :department, null: false
      t.string :position, null: false
      t.decimal :daily_salary, precision: 12, scale: 2, null: false
      t.decimal :salary, precision: 12, scale: 2, null: false
      t.string :entity_key, null: false
      t.string :state, null: false

      t.timestamps
    end

    create_table :managed_users do |t|
      t.references :owner_user, null: false, foreign_key: { to_table: :users }
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.text :rfc
      t.string :address, null: false
      t.string :phone, null: false
      t.string :website, null: false

      t.timestamps
    end
  end
end
