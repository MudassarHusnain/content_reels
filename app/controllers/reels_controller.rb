class ReelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reel, only: %i[ show edit update destroy ]
  def index
    @reels=Reel.all
    render
  end

  def show
  end

  def edit
  end

  def new
    @reel=Reel.new
    # @project=Project.find_by(params[:project_id])
  end

  def create
    # debugger
    @reel=Reel.new(reel_params)
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

  end

  private
  def set_reel
    @reel=Reel.find_by(params[:id])
  end

  def reel_params
    params.require(:reel).permit(:video_set,:keywords,:no_of_video,:platform,:cta,:project_id)
  end
end
