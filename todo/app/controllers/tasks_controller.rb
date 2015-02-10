class TasksController < ApplicationController

  before_action :get_user

  def index
  	@tasks = @user.tasks.all 
  	render :index  #this is implicit and we don't need this line to render this particular view
  end

  def new
  	@task = @user.tasks.new
  	render :new  #this is implicit and we don't need this line to render this particular view
  end

  def create

  	new_task = params.require(:task).permit(:content, :complete)
  	task = @user.tasks.create(new_task)
  	redirect_to "/users/#{@user.id}/tasks/#{task.id}" # have to use double quotes when we want to include objects into a string
  end

  def show

  	task_id = params[:task_id]
  	@meow_mix = Task.find(task_id)
  	render :show
  end

  def edit

  	task_id = params[:task_id]
  	@task = @user.tasks.find(task_id)
  	render :edit
  end

  def update

  	task_id = params[:task_id]
  	task = @user.tasks.find(task_id)
    updated_attrs = params.require(:task).permit(:content, :complete)
    task.update_attributes(updated_attrs)
  	redirect_to task_path # we can now call task_path because we indicated in our routes.rb task#show as: 'task'
  end

  def destroy

  	task_id = params[:task_id]
  	task = @user.tasks.find(task_id)
  	task.destroy
  	redirect_to tasks_path # redirects to index route
  end

  private
    def get_user
      user_id = params[:user_id]
      @user = User.find(user_id)
    end
end
