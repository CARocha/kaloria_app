class AddHeightToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :height, :float, null: false, default: 0.0
  end
end
