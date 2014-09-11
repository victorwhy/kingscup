redirect_uri = "http://localhost:9393/oauth2callback"
SCOPES = "https://www.googleapis.com/auth/plus.login"

get '/' do
  session.clear
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

  @user = User.find_or_create_by(google_id: @user_info["id"], google_pic: @user_info["picture"], profile_link: @user_info["link"], name: @user_info["name"])
  session[:current_user] = @user.id
  
  redirect '/game'
end

get '/sign_out' do 
  session.clear
  redirect '/'
end

