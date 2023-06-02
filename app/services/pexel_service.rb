class PexelService
  def search_photo
    client = Pexels::Client.new('Bjdhr8G7PNoIZEYW9FdxK8b16BBEzESMIFpoE6V304XJgsWkwHTBcimF')
    response=client.photos.search('Cloud')
  end

end
