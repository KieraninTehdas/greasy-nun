module HabitsHelper
  def habit_text(habit)
    start_or_stop = habit.start? ? "start" : "stop"

    "I want to #{start_or_stop} #{habit.name.downcase}"
  end
end
