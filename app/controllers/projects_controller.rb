class ProjectsController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @projects = Project.all.order(created_at: :desc).paginate(page: params[:page], per_page: 4)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      flash['success'] = "Project Successfully created!"
      redirect_to @project
    else
      flash['danger'] = "Failed to Create Project"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash['success'] = "Project Successfully updated!"
      redirect_to @project
    else
      flash['danger'] = "Failed to Update Project"
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title,:description, :banner, :project_url, :github_url)
    end
end
