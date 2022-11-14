class Api::V1::ConditionsController < ApplicationController

  before_action :set_condition, except: :create

  def create
    @condition = @current_user.conditions.build(condition_params)
    if @condition.save
      render json: {
                      condition: @condition,
                      message: "Condition has been added."
                    },
                    status: :created
    else
      render json: { errors: @condition.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def update
    if @condition.update(condition_params)
      render json: {
                      condition: @condition,
                      message: "Condition has been updated."
                    },
                    status: :ok
    else
      render json: { errors: @condition.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def destroy
    @condition.destroy
    render json: { message: "Condition has been removed." },
                  status: :ok
  end

  private

  def set_condition
    @condition = Condition.find(params[:id])
    no_record_found unless @condition
  end

  def condition_params
    params
      .require(:condition)
      .permit(:diagnosis, :start_date, :end_date)
  end
end
