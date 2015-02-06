class TasksController < ApplicationController
  def index
  	@tasks = Task.all 
  	render :index  #this is implicit and we don't need this line to render this particular view
  end

  def new
  	# @task = Task.new
  	render :new  #this is implicit and we don't need this line to render this particular view
  end

  def create
  	new_task = params.require(:task).permit(:content, :complete)
  	task = Task.create(new_task)
  	redirect_to "/tasks/#{task.id}" # have to use double quotes when we want to include objects into a string
  end

  def show
  	task_id = params[:id]
  	@meow_mix = Task.find(task_id)
  	render :show
  end

  def edit
  	task_id = params[:id]
  	@task = Task.find(task_id)
  	render :edit
  end

  def update
  	task_id = params[:id]
  	task = Task.find(task_id)
    updated_attrs = params.require(:task).permit(:content, :complete)
    task.update_attributes(updated_attrs)
  	redirect_to task_path # we can now call task_path because we indicated in our routes.rb task#show as: 'task'
  end

  def destroy
  	task_id = params[:id]
  	task = Task.find(task_id)
  	task.destroy
  	redirect_to tasks_path # redirects to index route
  end
end
