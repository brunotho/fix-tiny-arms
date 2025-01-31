RSpec.describe "navigation", type: :system do
  it "shows navigation links when signed in" do
    user = create(:user)
    sign_in user

    visit root_path

    expect(page).to have_link("Today's Habits")
    expect(page).to have_link("All Habits")
    expect(page).to have_link("New Habit")
  end

  it "hides mavigation when not signed in" do
    visit root_path
    expect(page).not_to have_link("Today's Habits")
  end
end
