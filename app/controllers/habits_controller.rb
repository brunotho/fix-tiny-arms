class HabitsController < ApplicationController
  def new
    @habit = Habit.new
  end

  def create
    puts "TIME VALUE: #{params.dig(:habit, :time_of_day)}"
    p "😍"
    puts "PARAMS: #{params.inspect}"  # what's coming in?
    @habit = current_user.habits.build(habit_params)
    puts "VALID? #{@habit.valid?}"    # is it valid?
    puts "ERRORS: #{@habit.errors.full_messages}" if !@habit.valid?

    if @habit.save
      puts "SAVED!"

      redirect_to habits_path, notice: "Habit created 👺"
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
