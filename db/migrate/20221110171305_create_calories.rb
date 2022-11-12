class CreateCalories < ActiveRecord::Migration[6.1]
  def change
    create_table :calories do |t|
      t.float :calories_ingested
      t.float :calories_burned
      t.text :comment
      t.datetime :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :calories, [:user_id, :created_at, :date, :comment]
  end
end
