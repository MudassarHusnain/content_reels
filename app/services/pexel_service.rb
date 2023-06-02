class PexelService
  def search_photo

    client = Pexels::Client.new( Rails.application.credentials[:pexel_key])
    response=client.photos.search('Cloud')
  end

end
