require 'rails_helper'

RSpec.describe "habits/new", type: :view do
  before(:each) do
    assign(:habit, Habit.new(
      name: "MyString",
      start: false
    ))
  end

  it "renders new habit form" do
    render

    assert_select "form[action=?][method=?]", habits_path, "post" do
      assert_select "input[name=?]", "habit[name]"

      assert_select "input[name=?]", "habit[start]"
    end
  end
end
