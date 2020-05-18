class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false
      t.references :message_template, null: false
      t.string :type, null: false
      t.string :status, null: false, default: :pending
      t.text :text, null: false

      t.timestamps
    end
  end
end
