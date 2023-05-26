class ReelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reel, only: %i[ show edit update destroy script editor ]

  def index
    @project = Project.find(params[:project_id])
    @reels = @project.reels.all
  end

  def show
  end

  def edit
  end

  def new
    @project = Project.find(params[:project_id])
    @reel = @project.reels.new
  end

  def create
    @reel = Reel.new(reel_params)
    chat = ChatService.new(content: @reel.video_set)
    @reel.script = chat.chat_data
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
    respond_to do |format|
      if @reel.destroy
        format.html { redirect_to reels_path(product_id: @reel.project_id), notice: "Project was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  def script
    # @reel = Reel.find(params[:id])
  end

  def editor
    @templates=Template.all

  end

  private

  def set_reel
    @reel = Reel.find(params[:id])
  end

  def reel_params
    params.require(:reel).permit(:video_set, :keywords, :no_of_video, :platform, :cta, :project_id)
  end
end
