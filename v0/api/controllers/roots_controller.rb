class V0
  module Api
    module Controllers

      get '/' do
        if current_user
          redirect '/user/portal'
        else
          redirect '/sign_in'
          # erb :public_portal
        end
      end

    end
  end
end
