require "rails_helper"

RSpec.describe Habit, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }

    describe "days_of_week" do
      it "rejects negative days" do
        habit = build(:habit, days_of_week: [-1])
        expect(habit).not_to be_valid
      end

      it "rejects days above 6" do
        habit = build(:habit, days_of_week: [7])
        expect(habit).not_to be_valid
      end

      it "rejects duplicate days" do
        habit = build(:habit, days_of_week: [1, 1])
        expect(habit).not_to be_valid
      end
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:habit_completions) }
  end

  describe "instance methods" do
    describe "#due_today?" do
      it "true when day_of_week includes today" do
        today = Date.current.wday
        habit = build(:habit, days_of_week: [today])
        expect(habit).to be_due_today
      end
    end

    describe "#completed_today?" do
      it "true when habit_completion record exists for habit that's due today" do
        habit = create(:habit)
        create(:habit_completion, habit: habit, completed_on: Date.current)
        expect(habit).to be_completed_today
      end
    end

    describe "#mark_completed!" do
      it "creates a habit_completion instance" do
        habit = create(:habit)
        expect { habit.mark_completed! }.to change {
          habit.habit_completions.where(completed_on: Date.current).count
        }.by(1)
      end

      it "fails to create habit_completion instance if one already exists for today" do
        habit = create(:habit)
        expect { habit.mark_completed! }.not_to raise_error
        expect { habit.mark_completed! }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end

  end

end
