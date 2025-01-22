RSpec.describe "Viewing habits", type: :system do
  it "shows today's habits in time order with completion status" do
    user = create(:user)
    sign_in user

    today = Date.current.wday
    early_habit = create(:habit,
      user: user,
      name: "Wake Up",
      time_of_day: "06:00",
      days_of_week: [today]
    )

    late_habit = create(:habit,
      user: user,
      name: "Do Something",
      time_of_day: "17:00",
      days_of_week: [today]
    )

    tomorrow_habit = create(:habit,
      user: user,
      name: "Not today",
      time_of_day: "11:00",
      days_of_week: [(today + 1) % 7]
    )

    early_habit.mark_completed!

    visit habits_path

    within(".habits-list") do
      habit_names = page.all(".habit-name").map(&:text)
      expect(habit_names).to eq(["Wake Up", "Do Something"])

      within("#habit-#{early_habit.id}") do
        expect(page).to have_field("completed", checked: true)
      end

      within("#habit-#{late_habit.id}") do
        expect(page).to have_field("completed", checked: false)
      end
    end
  end

  it "toggles completion with checkbox", js: true do
    user = create(:user)
    sign_in user

    today = Date.current.wday
    habit = create(:habit,
      user: user,
      name: "Wake Up",
      time_of_day: "06:00",
      days_of_week: [today]
    )

    visit habits_path

    within("#habit-#{habit.id}") do
      expect(page).to have_field("completed", checked: false)
      check "completed"
      expect(page).to have_field("completed", checked: true)
    end

    expect(habit.reload).to be_completed_today
  end
end
