class V0
  module Api
    module Controllers

      get '/user/portal' do
        @shortcuts = current_user.shortcuts
        erb :user_portal
      end

    end
  end
end
