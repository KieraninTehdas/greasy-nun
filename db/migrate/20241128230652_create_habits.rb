class CreateHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :habits do |t|
      t.string :name
      t.boolean :start

      t.timestamps
    end
  end
end
