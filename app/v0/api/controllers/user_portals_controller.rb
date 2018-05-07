class V0
  module Api
    module Controllers

      get '/user/portal' do
        @shortcuts = Shortcut.for( current_user )
        erb :user_portal
      end

    end
  end
end
