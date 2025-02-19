RSpec.describe "Viewing todays habits", type: :system do
  let(:user) { create(:user) }
  let(:today) { Date.current.wday }

  before do
    sign_in user
  end

  it "shows habits for today in time order" do
    early = create(:habit, user: user, name: "Wake Up", time_of_day: "03:00", days_of_week: [today])
    late = create(:habit, user: user, name: "Go Sleep", time_of_day: "20:00", days_of_week: [today])
    create(:habit, user: user, name: "Not today", time_of_day: "06:00", days_of_week: [(today + 1) % 7])

    visit root_path

    within(".habits-list") do
      habit_names = page.all(".habit-name").map(&:text)
      expect(habit_names).to eq(["Wake Up", "Go Sleep"])
    end
  end

  it "shows completion status" do
    habit = create(:habit, user: user, name: "Wake Up", days_of_week: [today])
    habit.mark_completed!

    visit root_path

    within("#habit-#{habit.id}") do
      expect(page).to have_field("completed", checked: true)
    end
  end

  it "allows navigation to habit show" do
    today = Date.current.wday
    habit = create(:habit,
      user: user,
      name: "Wake Up",
      days_of_week: [today]
    )

    visit root_path
    click_link "Wake Up"

    expect(page).to have_current_path(habit_path(habit))
  end

  describe "completion toggling", js: true do
    it "updates completion status" do
      habit = create(:habit, user: user, name: "Wake Up", days_of_week: [today])

      visit root_path

      within("#habit-#{habit.id}") do
        expect(page).to have_field("completed", checked: false)
        check "completed"
        expect(page).to have_field("completed", checked: true)
      end
      expect(habit.reload).to be_completed_today

      uncheck "completed"
      expect(page).to have_field("completed", checked: false)
      expect(habit.reload).not_to be_completed_today
    end
  end
end
