class BeepTimestampsJob < ApplicationJob
  queue_as :default

  def perform(habit_id)
    BeepTimestampsService.new.process(habit_id)
  end
end
