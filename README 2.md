# Oh My Auth! (Google)

## Learning Competencies

* Incorporate third-party gems into a web application using bundler
* Extend the Sinatra application environment with a ruby gem
* Implement user login and authentication in a web application
* Use a third-party API
* Implement OAuth


## Summary

Now that you've successfully completed the [Tweet Now! 2: Multi-User][Tweet Now! 2: Multi-User Challenge] challenge, you're probably ready to try to code-up your own OAuth conversation. This time, though, instead of using OAuth v1 with Twitter, you're going to use OAuth2 and Google.


## Releases

### Release 0 - Set Up Your API Access and Environment

#### Google API Access

The first thing you'll need to do is go to the [Google API Console][] to set up your API access. At the very least, you'll need to turn on access for the "Google+ API" under the "Services" tab.

After that, you'll need to create an OAuth2 web application Client ID under the "API Access" tab. When you're configuring your "Redirect URIs", it's important that they exactly match what you plan to use for your app (e.g., http://localhost:9393/oauth2callback).

#### Bundle Your Gems

When authenticating via Twitter, you used the `oauth` gem. For Google, however, we'll be using OAuth2, so we'll need the `oauth2` gem. Be sure that your `Gemfile` and `environment.rb` files are configured correcly for this gem, then run `bundle`:

```bash
$ bundle
```

#### Environment Variables

Remember how you configured your server environment with `TWITTER_KEY` and `TWITTER_SECRET` environment variables? You'll need to do something similar for Google. Obviously, you probably don't want to name these environment variables with `TWITTER_` this time.

#### Instantiating an OAuth2 Client

The [documentation for the oauth2 gem][OAuth2 Gem] doesn't have much specific in it about Google. As such, you might need to play around a bit to figure out the exact "incantation" to get a working `OAuth2::Client` object to work with. For example, it might look something like this ( **WARNING:** don't just cut-and-paste -- your mileage may vary).

```ruby
def oauth_client
  @client ||= OAuth2::Client.new(
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_CLIENT_SECRET'],
    :site => 'https://accounts.google.com',
    :token_url => '/o/oauth2/token',
    :authorize_url => '/o/oauth2/auth'
  )
end
```

### Release 1 - Build Your One Page App!

The core flow should work like this:

1. Application instantiates an `OAauth2::Client` object.
1. Application renders page with "Sign in Using Google" button.
1. User clicks "Sign in Using Google".
1. User is redirected to Google to authorize the application.
1. User authorizes application and is redirected to the redirect URI.
1. Application uses the verification code to get an access token.
1. Application queries Google for user information.
1. Application renders the index page along with the user's profile photo.

Here are the specifications:

1. If the user has not yet authenticated, display a "Sign in Using Google" button.
2. If the user has authenticated, display her Google profile picture, along with a "Sign Out" button.

The "Sign in Using Google" button should redirect the user to the Google authorization URL. This URL can be gotten using the `OAuth2::Client` instance that you figured out in the last step. For example:

```ruby
  uri = oauth_client.auth_code.authorize_url(
    :redirect_uri => '...', # <-- your redirect URI
    :scope => '...' # <-- determined by reading the Google OAuth2 docs
  )
```

You'll need to figure out what to pass for `redirect_uri' and `scope`. You'll probably need to [read Google's documentation][Google OAuth Scopes Documentation] to figure out exactly which scopes you need to send. You can separate multiple scopes with spaces.

You'll also need to implement the route for whatever you passed as `redirect_uri`. This route should use the `code` parameter that Google sends in order to get an access token. This token can then be used to query Google for additional information about the user who authenticated. For example:

```ruby
  token = oauth_client.auth_code.get_token(
    params[:code],
    :redirect_uri => '<same_as_above>'
  )
  response = token.get 'https://www.googleapis.com/oauth2/v1/userinfo?alt=json'
  user_info = JSON.parse(response.body)
```

The "Sign Out" button should flush the session variables and redirect to the home page of your application.

Be sure everything works on your local machine.

### Release 2 - Deploy to Heroku

Once you get things working locally, you should deploy it to Heroku and make sure everything still works.

Congratulations on hand-coding your first OAuth conversation!


## Resources

* [Tweet Now! 2: Multi-User Challenge][]
* [Google API Console][]
* [Google OAuth Scopes Documentation][]
* [OAuth2 Gem][]

[Tweet Now! 2: Multi-User Challenge]:https://github.com/Devbootcamp/tweet-now-2-multi-user-challenge
[Google API Console]:https://code.google.com/apis/console/
[Google OAuth Scopes Documentation]:https://developers.google.com/+/api/oauth#scopes
[OAuth2 Gem]:https://github.com/intridea/oauth2
