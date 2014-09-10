def oauth_client
  @client ||= OAuth2::Client.new(
    ENV['GOOGLE_KEY'],
    ENV['GOOGLE_SECRET'], 
    :site => 'https://accounts.google.com',
    :token_url => '/o/oauth2/token',
    :authorize_url => '/o/oauth2/auth'
  )
end