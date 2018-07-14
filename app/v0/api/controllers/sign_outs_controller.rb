class V0
  module Api
    module Controllers

      get '/sign_out' do
        current_user && current_user.sign_out && @current_user = nil
        erb :signed_out
      end

    end
  end
end
