RSpec.describe "Deleting habits", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "deletes habit" do
    habit = create(:habit,
      user: user,
      name: "Delete me!"
    )

    visit habits_path
    expect(page).to have_content("Delete me!")
    
    accept_confirm do
      click_button "(delete)"
    end

    expect(page).not_to have_content("Delete me!")
  end
end
