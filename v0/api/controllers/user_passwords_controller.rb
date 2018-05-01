class V0
  module Api
    module Controllers

      get '/user/password/edit' do
        erb :user_password_edit
      end

      post '/user/password' do
        if params[:new_password] == params[:new_password_confirmation]
          user = User.new( session, request, settings )
          if user.sign_in(
              system( without_token: true ),
              { uid: session[:uid], password: params[:current_password] } )
            system.engines_api_system.update_users_account_password( session[:uid], params[:new_password] )
            redirect "/"
          else
            halt 401
          end
        else
          erb :user_password_edit, message: "New password does not confirmation."
        end
      end

    end
  end
end
