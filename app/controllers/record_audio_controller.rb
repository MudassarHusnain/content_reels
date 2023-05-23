class RecordAudioController < ApplicationController
  require 'open-uri'

  def index
  end
  def microphone_audio
    params[:audio_blob]
  end

end
