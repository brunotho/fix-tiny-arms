class HabitsController < ApplicationController
  def new
    @habit = Habit.new
  end

  def create
    @habit = current_user.habits.build(habit_params)
    if @habit.save
      redirect_to habits_path
    else
      render :new, status: 422
    end
  end

  def index
    @habits = current_user.habits
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :time_of_day, days_of_week: [])
  end
end
