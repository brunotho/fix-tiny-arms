RSpec.describe "Editing habits", type: :system do
  it "updates habit details" do
    user = create(:user)
    sign_in user

    habit = create(:habit,
      user: user,
      name: "Old Name",
      time_of_day: "07:00",
      days_of_week: [1, 3]
    )

    visit habits_path
    click_link "(edit)"

    fill_in "Name", with: "New Name"
    select "09", from: "habit_time_of_day_4i"
    select "15", from: "habit_time_of_day_5i"
    uncheck "Monday"
    check "Tuesday"

    click_button "Update Habit"
    expect(page).to have_content "updated 💪"

    habit.reload
    expect(habit.name).to eq "New Name"
    expect(habit.time_of_day.strftime("%H:%M")).to eq "09:15"
    expect(habit.days_of_week).to match_array([2, 3])
  end

  it "prevents editing habits that aren't owned" do
    user = create(:user)
    not_my_habit = create(:habit, user: create(:user))

    sign_in user
    visit edit_habit_path(not_my_habit)

    expect(page).to have_current_path(habits_path)
    expect(page).to have_content "Not authorized"
  end
end
