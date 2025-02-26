RSpec.describe "Viewing the habit show-page", type: :system do
  let(:user) { create(:user) }
  let(:habit) do
    create(:habit,
      user: user,
      name: "Bopping",
      days_of_week: [Date.current.wday],
      time_of_day: "07:00",
      youtube_url: "https://www.youtube.com/watch?v=M4XKNXMMvi4&ab_channel=ZelenValo"
    )
  end

  before do
    sign_in user
  end

  it "shows habit content" do
    visit habit_path(habit)

    expect(page).to have_content("Bopping")
    expect(page).to have_button("Done")
  end

  describe "YouTube video" do
    it "embeds player when URL is present" do
      visit habit_path(habit)

      expect(page).to have_selector("iframe[src*='youtube.com/embed']")
    end

    it "shows no video player when URL is absent" do
      habit_without_video = create(:habit, youtube_url: nil)
      visit habit_path(habit_without_video)
      expect(page).not_to have_selector("iframe")
    end
  end

  it "redirects to today view with completion feedback on 'Done'" do
    visit habit_path(habit)
    click_button "Done"

    expect(page).to have_current_path(root_path)

    within("#habit-#{habit.id}") do
      expect(page).to have_field("completed", checked: true)
    end

    expect(page).to have_content("Get it! 💪")
  end
end
