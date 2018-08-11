class V0
  module Api
    module Controllers

      get '/sign_in' do
        unless settings.no_captcha?
          @captcha = Captcha.new( session, settings )
          @captcha.generate_challenge
        end
        erb :sign_in
      end

      post '/sign_in' do
        begin
          unless settings.no_captcha?
            @captcha = Captcha.new( session, settings )
            @captcha.try params[:captcha]
          end
          user = User.new( session, request, settings )
          user.sign_in( system( without_token: true ), params[:sign_in] )
          redirect '/user/portal'
        rescue NonFatalError => e
          raise unless e.status_code == 405
          redirect '/sign_in', alert: "Invalid username, password or captcha."
        end
      end

    end
  end
end
