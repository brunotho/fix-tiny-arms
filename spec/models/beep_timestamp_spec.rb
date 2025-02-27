require 'rails_helper'

RSpec.describe BeepTimestamp, type: :model do
  describe "associations" do
    it { should belong_to(:habit) }
  end
end
