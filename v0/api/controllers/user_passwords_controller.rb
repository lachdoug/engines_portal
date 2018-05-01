class V0
  module Api
    module Controllers

      get '/user/password/edit' do
        erb :user_password_edit
      end

      post '/user/password' do
        byebug
        user = User.new( session, request, settings )
        if user.sign_in(
            system( without_token: true ),
            { user_name: session[:dn], password: session[:password] } )
          system.engines_api_system.update_users_account_password( session[:user_name], password )
          redirect "/"
        else
          halt 401
        end
      end

    end
  end
end
