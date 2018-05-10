class V0
  module Api
    module Controllers

      get '/control_panel/accounts' do
        halt 401 unless current_user.is_admin?
        @accounts = system.engines_api_system.index_users_accounts
        erb :'accounts/index'
      end

    end
  end
end
