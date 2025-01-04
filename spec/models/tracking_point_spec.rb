require 'rails_helper'

RSpec.describe TrackingPoint, type: :model do
  describe "#has_data" do
    it "defaults to true" do
      expect(TrackingPoint.new().has_data).to be true
    end
  end
end
