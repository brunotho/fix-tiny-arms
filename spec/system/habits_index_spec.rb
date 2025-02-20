RSpec.describe "Habits Index", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "shows all habits (with edit control)" do
    habit = create(:habit,
      user: user,
      name: "Yoga etc",
      days_of_week: [1, 3, 5]
    )

    visit habits_path

    within(".habits-list") do
      expect(page).to have_content("Yoga etc")
      expect(page).to have_link("(edit)")
      expect(page).not_to have_field("completed")
    end
  end
end
