class ReelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reel, only: %i[ show edit update destroy ]

  def index

    @project = Project.find(params[:project_id])
    @reels = @project.reels.all
  end

  def show
  end

  def edit
  end

  def new

    @project = Project.find_by(params[:project_id])
    @reel = @project.reels.new
    # debugger
  end

  def create
    # debugger
    @reel = Reel.new(reel_params)
    respond_to do |format|
      if @reel.save
        format.html { redirect_to projects_url, notice: "Reel was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
    @reel.destroy
    respond_to do |format|
      format.html { redirect_to reels_path(product_id:@reel.project_id), notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_reel
      @reel = Reel.find(params[:id])
    end

    def reel_params
      params.require(:reel).permit(:video_set,:keywords,:no_of_video,:platform,:cta,:project_id)
    end
end
