class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

end
# "1264161897640318
# EAANlyZCZCgMJsBAO1Q4de0i8c47XDcTZBBBMC9uPGaiRnFqsOW6R4B9rmC0I8YGk0ftXZCjOmS0XLpjI7ETvzOmj7KG4KVUOzPQEgnm2xhcs1x976r0ACnYPHrO82FTSdUwmOCTZAEomlohDon2Su9wstIjlhxkqtCa4kU1kzoS4vBcpkWM1WrTFUTTa72YskKWIqkaSfDmd8EzRVoxxn
#
# curl -i -X GET "https://graph.facebook.com/1264161897640318/accounts?access_token=EAANlyZCZCgMJsBADRvURuqjPp3yuVFZBUa3i3FCspO5MZAhevfGzZCKnZCJopKcttwjI1s6PNxz1c6zltyJ1NknYVVErndfWacD1ZCisI0izio4EPZBRveXV0rflRSaTtbuYGOq3Ny6OIKGGZC7MrGzUdBvXZAn50UFGo9L8KNHZAnZC8l5j7pEw5NLZCZCZAn1DZBgKc2YeP5lRETIVbCTYhLzOWKjc"
#
# curl -i -X GET "https://graph.facebook.com/oauth/access_token?client_id=956351775781019&client_secret=98eea40682886712f9239b286b5f9a10"
# curl -i -X GET "https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=956351775781019&client_secret=98eea40682886712f9239b286b5f9a10&fb_exchange_token=EAANlyZCZCgMJsBAFg8z3UIJKsYdLrRcpKQLVtSfVuOp17pfpdHRFZBhyZCnpWp0peDoqbeNjyUXKOGZBA0vWKhaKOAoDBOMI8xS0ZCE4FUseKjf27ygDMMQzJRV7FAM7oUSd2sV8Ej1BVzCKQh1PTsqVNhwCE5eUIeCqbZAMKS52z9Of2mMhFFyVmDyVfJY7WVWrRd7zdCvr3SZAAttAys6Noo9Xg0VwzO8RehZCOrqAeZBW9rcVI0UAWy"