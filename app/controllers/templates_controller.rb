class TemplatesController < ApplicationController
  before_action :set_reel, only: [:new, :create]

  def index
  end

  def new
    @template = @reel.templates.new
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to editor_reel_url(id: @template.reel_id)
    else
      render "new"
    end
  end

  private

  def set_reel
    @reel = Reel.find_by(id: params[:reel_id])
  end

  def template_params
    params.require(:template).permit(:file, :reel_id)
  end
end
