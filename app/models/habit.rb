class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_completions

  validates :name,
            presence: true
  validates :days_of_week,
            presence: true

  validate :days_of_week_must_be_array
  validate :days_must_be_valid_integers
  validate :days_must_be_unique

  def due_today?
    days_of_week.include?(Time.now.wday)
  end

  def completed_today?
    habit_completions.where(completed_on: Date.today).exists?
  end

  def mark_completed!
    habit_completions.create!(completed_on: Date.today)
  end

  scope :due_today, -> { where("? = ANY(days_of_week)", Time.current.wday) }

  private

  def days_of_week_must_be_array
    errors.add(:days_of_week, "must be an array") unless days_of_week.is_a?(Array)
  end

  def days_must_be_valid_integers
    return if days_of_week.all? { |day| day.is_a?(Integer) && day.between?(0, 6) }
    errors.add(:days_of_week, "all days must be integers between 0-6")
  end

  def days_must_be_unique
    return if days_of_week == days_of_week.uniq
    errors.add(:days_of_week, "all days must be unique")
  end
end
