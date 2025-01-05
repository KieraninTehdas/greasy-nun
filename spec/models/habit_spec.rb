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

  describe "#update_status_on_date" do
    let(:habit)  { create(:habit) }
    let(:date) { Date.today }

    subject { habit.update_status_on_date(date, true) }

    context "when tracking point doesn't exist" do
      it "creates a tracking point" do
        expect { subject }.to change(TrackingPoint, :count).by(1)
      end

      it "sets the correct status" do
        expect(subject.succeeded?).to be true
      end
    end

    context "when tracking point exists" do
      let!(:tracking_point) { create(:tracking_point, habit: habit, date_point: date, succeeded: false) }

      it "updates the status" do
        expect(subject.succeeded?).to be true
      end
    end
  end

  describe "#history_between" do
    before { travel_to Time.utc(2025, 1, 2, 23, 2) }

    subject { habit.history_between(start_date, end_date) }

    let(:habit) { create(:habit) }
    let(:start_date) { 7.days.ago.to_date }
    let(:end_date) { Date.today }

    context "when there are no tracking points" do
      it "returns a tracking point for each date in scope" do
        expect(subject.length).to eq(8)
      end

      it "returns not succeeded tracking points" do
        expect(subject.map { |tp| tp.succeeded? }).to eq(Array.new(8, false))
      end
    end

    context "when there are some tracking points in scope" do
      let!(:out_of_scope_point) { create(:tracking_point, habit:, date_point: 9.days.ago.to_date, succeeded: true,) }
      let!(:succeeded_point) { create(:tracking_point, habit:, date_point: 7.days.ago.to_date, succeeded: true) }
      let!(:failed_point) { create(:tracking_point, habit:, date_point: Date.today, succeeded: false) }

      it "fills the missing points with no data points" do
        expect(subject.length).to eq(8)
        expect(subject[3].has_data?).to be false
      end

      it "includes the in-scope tracking points" do
        expect(subject).to include(succeeded_point, failed_point)
      end

      it "doesn't include out of scope tracking points" do
        expect(subject).not_to include(out_of_scope_point)
      end

      it "sorts by date, ascending" do
        expect(subject).to eq(subject.sort_by(&:date_point))
      end
    end
  end
end
