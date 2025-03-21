RSpec.describe BeepTimestampsJob do
  describe "#perform" do
    it "enqueues proper" do
      habit = create(:habit, youtube_url: "https://www.youtube.com/watch?v=qBGsQT6b7D0")

      expect {
        BeepTimestampsJob.perform_later(habit.id)
      }.to have_enqueued_job(BeepTimestampsJob).with(habit.id)
    end

    it "calls beep_timestamps service with habit ID" do
      habit = create(:habit, youtube_url: "https://www.youtube.com/watch?v=qBGsQT6b7D0")
      service = instance_double(BeepTimestampsService)
      allow(BeepTimestampsService).to receive(:new).and_return(service)
      expect(service).to receive(:process).with(habit.id)

      BeepTimestampsJob.new.perform(habit.id)
    end
  end
end
