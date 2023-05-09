class OmniauthController < ApplicationController
  def facebook

    @user = user.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
    else
      flash[:error] = "There was problem signing in through facebook"
      redirect_to new_user_registration_path
    end
  end
end

#
# curl -i -X GET "https://graph.facebook.com/1264161897640318/accounts?access_token=EAANlyZCZCgMJsBAP1kXUGZBuPnTAUAFX6OZAA6Muj4Br6hx1Owd4rW70NJ0JtBIqCO9wKLkJ2k2PKDkh3AgLTEAdskh6dpA5GTy2MYmAkkBJHAleFnnTpgeKaTKTJikx94U8mWHCQtZBlEjZArsvI1SV3jOicBohsZCc4S1piGyQ6nBk0X1tUNk2uYuorifWDcbdbZB3bmmZAfWBC6ZC76BLFEaVkaktc7I3HAIJfckIPXBXLmHRnUBpNe"
# curl -i -X GET "https://graph.facebook.com/PAGE-ID?access_token=EAANlyZCZCgMJsBAEcrZBQMhs63EyMIxv9gRU1QxebXLxWgORmhUns7ey545s5RXJv8apae03IeyrKJwhytNmkluNb9ZANGcEWGYd82BJ687buIZAlrjnuwBLvMkGRrHqBSJFe9al4pPZCInRyK4MkIllVnoQHkHvYzO06ZCZAWacRTjYPokGgZAPkjKRz53EWZC7GI7m09keE4aD8gQGavEFqTH3bIZBC6W3yGUQ1S3aAwR0rijIrFqBqAw"
#
# curl -i -X GET "https://graph.facebook.com/me/accounts?type=page&access_token=EAANlyZCZCgMJsBAP1kXUGZBuPnTAUAFX6OZAA6Muj4Br6hx1Owd4rW70NJ0JtBIqCO9wKLkJ2k2PKDkh3AgLTEAdskh6dpA5GTy2MYmAkkBJHAleFnnTpgeKaTKTJikx94U8mWHCQtZBlEjZArsvI1SV3jOicBohsZCc4S1piGyQ6nBk0X1tUNk2uYuorifWDcbdbZB3bmmZAfWBC6ZC76BLFEaVkaktc7I3HAIJfckIPXBXLmHRnUBpNe"
# curl -i -X GET "https://graph.facebook.com/v2.3/me?access_token=EAANlyZCZCgMJsBAP1kXUGZBuPnTAUAFX6OZAA6Muj4Br6hx1Owd4rW70NJ0JtBIqCO9wKLkJ2k2PKDkh3AgLTEAdskh6dpA5GTy2MYmAkkBJHAleFnnTpgeKaTKTJikx94U8mWHCQtZBlEjZArsvI1SV3jOicBohsZCc4S1piGyQ6nBk0X1tUNk2uYuorifWDcbdbZB3bmmZAfWBC6ZC76BLFEaVkaktc7I3HAIJfckIPXBXLmHRnUBpNe&fields=name,email&locale=en_US&method=get&pretty=0&sdk=joey&suppress_http_code=1"