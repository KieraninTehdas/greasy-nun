class HabitsController < ApplicationController
  before_action :set_habit, only: %i[ show edit update destroy cycle_status more_history ]

  # GET /habits
  def index
    @good_habits = Habit.good
    @bad_habits = Habit.bad
  end

  # GET /habits/1
  def show
    @history = @habit.history_between(7.days.ago, Date.today)
  end

  # GET /habits/new
  def new
    @habit = Habit.new
  end

  # GET /habits/1/edit
  def edit
  end

  # POST /habits
  def create
    @habit = Habit.new(habit_params)

    if @habit.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /habits/1
  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: "Habit was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /habits/1
  def destroy
    @habit.destroy!
    redirect_to habits_url, notice: "Habit was successfully destroyed.", status: :see_other
  end

  def cycle_status
    @tracking_point = @habit.tracking_points.find_or_create_by(
      date_time_point: params[:date_time_point].to_datetime
    ) do |tracking_point|
      tracking_point.succeeded = false
    end

    @tracking_point.update!(succeeded: !@tracking_point.succeeded?)

    respond_to do |format|
      format.html { redirect_to habit_path(@habit) }
      format.turbo_stream
    end
  end

  def more_history
    start_date = params[:start_date]
    end_date = params[:end_date]

    if start_date.present?
      start_date = start_date.to_datetime()
      @history = @habit.history_between(start_date, 7.days.after(start_date))
    else
      end_date = end_date.to_datetime()
      @history = @habit.history_between(7.days.before(end_date), end_date)
    end

    respond_to do |format|
      format.html { render :show }
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_habit
      @habit = Habit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def habit_params
      params.require(:habit).permit(:name, :start)
    end

end
