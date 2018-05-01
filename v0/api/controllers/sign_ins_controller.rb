class V0
  module Api
    module Controllers

      get '/sign_in' do
        erb :sign_in, locals: { message: nil }
      end

      post '/sign_in' do
        begin
          user = User.new( session, request, settings )
          user.sign_in( system( without_token: true ), params[:sign_in] )
          redirect '/user/portal'
        rescue => e
          raise unless e.is_a?(NonFatalError) && e.status_code == 401
          erb :sign_in, message: "Invalid username or password."
        end
      end

    end
  end
end
