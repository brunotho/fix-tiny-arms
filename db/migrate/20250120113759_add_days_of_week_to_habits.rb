class AddDaysOfWeekToHabits < ActiveRecord::Migration[7.2]
  def change
    add_column :habits, :days_of_week, :integer, array: true, default: []
  end
end
