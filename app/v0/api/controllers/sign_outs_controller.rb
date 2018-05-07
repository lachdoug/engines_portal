class V0
  module Api
    module Controllers

      get '/sign_out' do
        current_user.sign_out if current_user
        erb :signed_out
      end

    end
  end
end
