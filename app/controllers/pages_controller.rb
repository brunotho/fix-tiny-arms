class PagesController < ApplicationController
  def today
    @habits = current_user.habits.due_today.ordered_by_time
  end
end
