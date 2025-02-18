RSpec.describe "Viewing the habit show-page", type: :system do
  let(:user) { create(:user) }
  let(:habit) do
    create(:habit,
      user: user,
      name: "Yoga",
      days_of_week: [Date.current.wday],
      time_of_day: "07:00",
      youtube_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    )
  end

  before do
    sign_in user
  end

  it "shows habit content" do
    visit habit_path(habit)

    expect(page).to have_content("Yoga")
    expect(page).to have_selector("iframe[src*='youtube.com']")
    expect(page).to have_button("Done")
  end

  it "redirects to today view with completion feedback" do
    visit habit_path(habit)
    click_button "Done"

    expect(page).to have_current_path(root_path)

    within("#habit-#{habit.id}") do
      expect(page).to have_field("completed", checked: true)
    end

    expect(page).to have_content("Get it! 💪")
  end
end
