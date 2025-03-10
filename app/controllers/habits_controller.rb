class HabitsController < ApplicationController
  def index
    @habits = current_user.habits
  end

  def show
    @habit = current_user.habits.find(params[:id])
  end

  def new
    @habit = Habit.new
  end

  def create
    @habit = current_user.habits.build(habit_params)

    if @habit.save
      redirect_to habits_path, notice: "Habit created 👺"
    else
      render :new, status: 422
    end
  end

  def edit
    @habit = current_user.habits.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to habits_path, alert: "Not authorized"
  end

  def update
    @habit = current_user.habits.find(params[:id])

    if @habit.update(habit_params)
      redirect_to habits_path, notice: "Habit updated 💪"
    else
      render :edit, status: 422
    end
  end

  def destroy
    @habit = current_user.habits.find(params[:id])
    @habit.destroy
    redirect_to habits_path, notice: "Habit deleted 💀"
  end

  def mark_completed
    @habit = current_user.habits.find(params[:id])
    @habit.mark_completed! unless @habit.completed_today?
    redirect_to root_path, notice: "Get it! 💪"
  end

  def toggle_completed
    @habit = current_user.habits.find(params[:id])
    @habit.completed_today? ? @habit.uncomplete! : @habit.mark_completed!

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          @habit,
          partial: "habits/habit_for_today",
          locals: { habit: @habit }
        )
      }
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :time_of_day, :youtube_url, days_of_week: [])
  end
end
