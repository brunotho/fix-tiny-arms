class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_completions, dependent: :destroy

  YOUTUBE_URL_REGEX = /\A((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?\z/

  validates :name,
            presence: true
  validates :time_of_day,
            presence: true
  validates :youtube_url,
            format: { with: YOUTUBE_URL_REGEX, message: "must be a valid YouTube URL" },
            allow_blank: true
  validates :days_of_week,
            presence: true

  validate :days_of_week_must_be_array
  validate :days_must_be_valid_integers
  validate :days_must_be_unique

  def due_today?
    days_of_week.include?(Date.current.wday)
  end

  def completed_today?
    habit_completions.where(completed_on: Date.current).exists?
  end

  def mark_completed!
    habit_completions.create!(completed_on: Date.current)
  end

  def uncomplete!
    habit_completions.where(completed_on: Date.current).destroy_all
  end

  scope :due_today, -> { where("? = ANY(days_of_week)", Date.current.wday) }
  scope :ordered_by_time, -> { order(:time_of_day) }

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
