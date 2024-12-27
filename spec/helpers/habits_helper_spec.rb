require 'rails_helper'

RSpec.describe HabitsHelper, type: :helper do
  describe "#habit_text" do
    subject { helper.habit_text(habit) }

    context "when habit is good :)" do
      let(:habit) { Habit.new(name: "Running every day", start: true) }

      it { is_expected.to eq("I want to start running every day") }
    end

    context "when habit is bad :(" do
      let(:habit) { Habit.new(name: "Running every day", start: false) }

      it { is_expected.to eq("I want to stop running every day") }
    end
  end
end
