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
        rescue NonFatalError => e
          raise unless e.status_code == 405
          erb :sign_in, message: "Invalid username or password."
        end
      end

    end
  end
end
