Rails.application.config_middleware.use OmniAuth::Builder do 
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], ski_jwt: 
    true 
end 