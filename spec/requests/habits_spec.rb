require 'rails_helper'

RSpec.describe "/habits", type: :request do
  let(:valid_attributes) { { name: "Kick the Habit", start: false } }

  let(:invalid_attributes) { { name: "", start: false } }

  describe "GET /index" do
    it "renders a successful response" do
      Habit.create! valid_attributes
      get habits_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      habit = Habit.create! valid_attributes
      get habit_url(habit)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_habit_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      habit = Habit.create! valid_attributes
      get edit_habit_url(habit)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Habit" do
        expect {
          post habits_url, params: { habit: valid_attributes }
        }.to change(Habit, :count).by(1)
      end

      it "redirects to the created habit" do
        post habits_url, params: { habit: valid_attributes }
        expect(response).to redirect_to(habits_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Habit" do
        expect {
          post habits_url, params: { habit: invalid_attributes }
        }.to change(Habit, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post habits_url, params: { habit: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested habit" do
        habit = Habit.create! valid_attributes
        patch habit_url(habit), params: { habit: new_attributes }
        habit.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the habit" do
        habit = Habit.create! valid_attributes
        patch habit_url(habit), params: { habit: new_attributes }
        habit.reload
        expect(response).to redirect_to(habit_url(habit))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        habit = Habit.create! valid_attributes
        patch habit_url(habit), params: { habit: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested habit" do
      habit = Habit.create! valid_attributes
      expect {
        delete habit_url(habit)
      }.to change(Habit, :count).by(-1)
    end

    it "redirects to the habits list" do
      habit = Habit.create! valid_attributes
      delete habit_url(habit)
      expect(response).to redirect_to(habits_url)
    end
  end

  describe "PUT /status" do
    let(:habit)  { create(:habit) }
    let(:date_point) { Date.today }

    context "when request format is html" do
      it "redirects to the habit" do
        put update_status_on_date_habit_url(habit), params: { date_point:, succeeded: true }

        expect(response).to redirect_to(habit)
      end
    end

    context "when request format is turbo stream" do
      it "returns a turbo stream" do
        headers = { "ACCEPT": "text/vnd.turbo-stream.html" }

        put update_status_on_date_habit_url(habit), params: { date_point:, succeded: true }, headers: headers

        expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      end
    end

    context "when there is no data for tracking point" do
      it "creates a tracking point" do
        expect do
          put update_status_on_date_habit_url(habit), params: { date_point:, succeeded: true }
        end.to change(TrackingPoint, :count).by(1)
        expect(TrackingPoint.last.succeeded?).to be true
      end
    end

    context "when updating to failed" do
      let!(:tracking_point) { create(:tracking_point, habit:, succeeded: true, date_point:)}

      it "is updated to failed" do
        put update_status_on_date_habit_url(habit), params: { date_point:, succeeded: false }

        tracking_point.reload
        expect(tracking_point.succeeded?).to be false
      end
    end

    context "when updating to succeeded" do
      let!(:tracking_point) { create(:tracking_point, habit:, succeeded: false, date_point:)}

      it "is updated to succeeded" do
        put update_status_on_date_habit_url(habit), params: { date_point:, succeeded: true }

        tracking_point.reload
        expect(tracking_point.succeeded?).to be true
      end
    end
  end
end
