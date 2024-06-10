class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :token, limit: 36, null: false, index: { unique: true }
      t.integer :chats_count, default: 0

      t.timestamps
    end
  end
end
