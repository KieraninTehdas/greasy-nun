require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe "habit scopes" do
    let(:good_habits) { create_list(:habit, 3, :good) }
    let(:bad_habits) { create_list(:habit, 2, :bad) }

    describe "good" do
      it "returns habits where start attribute is true" do
        expect(Habit.good).to eq(good_habits)
      end
    end

    describe "bad" do
      it "returns habits where start attribute is false" do
        expect(Habit.bad).to eq(bad_habits)
      end
    end
  end

  describe "#stop?" do
    context "when start attribute is true" do
      subject { Habit.new(start: true).stop? }

      it { is_expected.to be false }
    end

    context "when start attribute is false" do
      subject { Habit.new(start: false).stop? }

      it { is_expected.to be true }
    end
  end

  describe "#history_between" do
    before { travel_to Time.utc(2025, 1, 2, 23, 2) }

    subject { habit.history_between(start_date, end_date) }

    let(:habit) { create(:habit) }
    let(:start_date) { 7.days.ago }
    let(:end_date) { DateTime.now }

    context "when there are no tracking points" do
      it "returns a tracking point for each date in scope" do
        expect(subject.length).to eq(8)
      end

      it "returns not succeeded tracking points" do
        expect(subject.map { |tp| tp.succeeded? }).to eq(Array.new(8, false))
      end
    end
  end
end
