class AddTimeOfDayToHabits < ActiveRecord::Migration[7.2]
  def change
    add_column :habits, :time_of_day, :time, null: false
  end
end
