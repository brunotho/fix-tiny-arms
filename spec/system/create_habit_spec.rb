
RSpec.describe "Creating a habit", type: :system do
  it "creates habit with form inputs" do
    user = create(:user)
    sign_in user

    visit new_habit_path

    fill_in "habit_name", with: "Juggle Diaries"
    fill_in "habit_youtube_url", with: "https://www.youtube.com/watch?v=hqiDnMvgQas&ab_channel=DiLorenzoFamily"
    select "05", from: "habit_time_of_day_4i"
    select "00", from: "habit_time_of_day_5i"
    check "Monday"
    check "Wednesday"
    check "Friday"
    click_button "Create Habit"

    expect(page).to have_content("Juggle Diaries")
    expect(Habit.last.days_of_week).to match_array([1, 3, 5])
    expect(Habit.last.time_of_day.strftime("%H:%M")).to eq "05:00"
  end

  it "shows errors for invalid input" do
    user = create(:user)
    sign_in user

    visit new_habit_path
    click_button "Create Habit"

    expect(page).to have_content("can't be blank")
  end
end
