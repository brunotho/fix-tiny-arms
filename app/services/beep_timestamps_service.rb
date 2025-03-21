class BeepTimestampsService
  def process(habit_id)
    habit = Habit.find(habit_id)
    p "creating video timestamps for habit: #{habit.name}"
  end
end
