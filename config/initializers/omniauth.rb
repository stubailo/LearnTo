Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == "production"
    provider :facebook, '349006175111553', 'd469a361b96aad1e9a6ca40c4ed7c5a9'
  else
    provider :facebook, '281967511856926', '09c26879f9136f4dd1d2d372eb1a9df8'
  end
end

