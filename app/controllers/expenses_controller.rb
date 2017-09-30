class ExpensesController < ApplicationController

  def create
    puts params
    expense = Expense.new(expense_params)
    if expense.save
      render json: expense
    else
      puts expense.errors.full_messages
      render json: {errors: expense.errors.full_messages}
    end
  end

  def show
    group = Group.find_by(id: params[:group_id])
    expense = Expense.find_by(id: params[:expense_id])
    if expense && expense.group == group
      render json: expense.json_data
    else
      render json: {error: "Expense does not exist, please try again"}
    end
  end

  def destroy
    expense = Expense.find_by(id: params[:id])
    if expense.destroy
      render json: {message: "Delete successful"}
    else
      render json: {message: "Something went wrong"}
    end
  end

  private
  def expense_params
    params.require(:expense).permit(:amount, :vendor, :description, :membership_id)
  end
end
