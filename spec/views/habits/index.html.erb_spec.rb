require 'rails_helper'

RSpec.describe "habits/index", type: :view do
  before(:each) do
    assign(:habits, [
      Habit.create!(
        name: "Name",
        start: false
      ),
      Habit.create!(
        name: "Name",
        start: false
      )
    ])
  end

  it "renders a list of habits" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
