class TestPrecision < ActiveRecord::Migration[7.0]
  def change
    create_table :precision_tests do |t|
      t.string :name, null: false, index: { unique: true }
      t.datetime :dt_via_create_table
      t.timestamps
    end

    add_column :precision_tests, :dt_via_add_column, :datetime

    change_table :precision_tests, bulk: true do |t|
      t.column :dt_via_change_table, :datetime
    end
  end
end
