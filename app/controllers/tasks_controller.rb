class TasksController < ApplicationController
  before_action :set_task, only: [:complete, :destroy, :edit, :update, :show]

  # GET /tasks
  def index
    @incomplete_tasks = Task.where(status: false)
    @complete_tasks = Task.where(status: true)
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.status = false # default to incomplete

    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      render :index
    end
  end

  # GET /tasks/:id
  def show
    @task = Task.find(params[:id])
  end

  def complete
    @task.update(status: true)
    redirect_to tasks_path, notice: 'Task completed successfully!'
  end

# DELETE /tasks/:id
  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path, notice: 'Task deleted successfully!'
  end

  # GET /tasks/:id/edit
  def edit
  end

  # PATCH /tasks/:id
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end