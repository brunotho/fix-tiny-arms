RSpec.describe "Habits", type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET /habits/new" do
    it "returns successful response" do
      get new_habit_path

      expect(response).to be_successful
    end
  end

  describe "POST /habits" do
    let(:valid_params) do
      {
        habit: {
          name: "dance in the sun",
          days_of_week: [2, 3, 5],
          time_of_day: "09:00"
        }
      }
    end

    context "with valid params" do
      it "creates new habit" do
        expect {
          post habits_path, params: valid_params
        }.to change(Habit, :count).by(1)
      end

      it "redirects to habits index" do
        post habits_path, params: valid_params
        expect(response).to redirect_to(habits_path)
      end

      it "sets current user as habit owner" do
        post habits_path, params: valid_params
        expect(Habit.last.user).to eq(user)
      end
    end

    context "with invalid params" do
      it "does not create habit" do
        expect {
          post habits_path, params: { habit: { name: "" } }
        }.not_to change(Habit, :count)
      end

      it "returns unprocessable entity status" do
        post habits_path, params: { habit: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /habits" do
    it "shows current_user's habits" do
      my_habit = create(:habit, user: user, name: "Damn, I look good")
      other_user = create(:user)
      other_habit = create(:habit, user: other_user, name: "Not my habit")

      get habits_path

      expect(response.body).to include("Damn, I look good")
      expect(response.body).not_to include("Not my habit")
    end
  end
end
