redirect_uri = "http://localhost:9393/oauth2callback"
SCOPES = "https://www.googleapis.com/auth/plus.login"

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/auth' do
  redirect oauth_client.auth_code.authorize_url(:redirect_uri => redirect_uri,:scope => SCOPES)
end


get '/oauth2callback' do
  token = oauth_client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
  session[:access_token] = token.token
  @message = "Successfully authenticated with the server"
  @access_token = session[:access_token]
  response = token.get 'https://www.googleapis.com/oauth2/v1/userinfo?alt=json'
  @user_info = JSON.parse(response.body)

  # session[:current_user] = @user
  
  erb :success
end

get '/sign_out' do 
  session.delete(:access_token)
  session.clear
  redirect '/'
end

