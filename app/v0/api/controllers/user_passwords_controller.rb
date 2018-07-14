class V0
  module Api
    module Controllers

      get '/user/password/edit' do
        erb :user_password_edit
      end

      post '/user/password' do
        if params[:new_password] == ""
          redirect '/user/password/edit', alert: "Please enter a new password."
        elsif params[:new_password] == params[:new_password_confirmation]
          user = User.new( session, request, settings )
          begin
              user.sign_in(
                system( without_token: true ),
                { uid: session[:uid], password: params[:current_password] } )
              system.api.update_users_account_password( session[:uid], params[:new_password] )
              user.sign_out
              redirect "/user/password/success"
            rescue NonFatalError
              redirect '/user/password/edit', alert: "Invalid current password."
            end
        else
          redirect '/user/password/edit', alert: "New password does not match confirmation."
        end
      end

      get "/user/password/success" do
        erb :user_password_success
      end

    end
  end
end
