class HabitsController < ApplicationController
  def new
    redirect_to edit_habit_path if current_user.habit
    @habit = current_user.build_habit
  end

  def create
    @habit = current_user.build_habit(habit_params)
    if @habit.save
      current_user.habit_logs.create!(name: @habit.name, event: "登録")
      redirect_to root_path, notice: "習慣を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @habit = current_user.habit || redirect_to(new_habit_path)
  end

  def update
    @habit = current_user.habit
    old_name = @habit.name
    if @habit.update(habit_params)
      current_user.habit_logs.create!(name: @habit.name, event: "変更") if old_name != @habit.name
      redirect_to root_path, notice: "習慣を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit = current_user.habit
    current_user.habit_logs.create!(name: @habit.name, event: "削除")
    @habit.destroy
    redirect_to root_path, notice: "目標を削除しました。記録は履歴に残っています。"
  end

  private

  def habit_params
    params.require(:habit).permit(:name)
  end
end
