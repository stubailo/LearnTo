Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'dP3oGZsNLJ30OkQTNRKwEA', 'd5SPb6xjaMPGZnmH96nSbf2uxalYfvvuWsP3hb8nU'
  provider :facebook, '281967511856926', '09c26879f9136f4dd1d2d372eb1a9df8'
  provider :google, '689142367852.apps.googleusercontent.com', 'cpdJlVXFYDViMGHt3q0sxFoJ'
end

