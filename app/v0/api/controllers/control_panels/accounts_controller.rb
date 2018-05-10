class V0
  module Api
    module Controllers

      get '/control_panel/accounts' do
        halt 401 unless current_user.is_admin?
        @accounts = system.accounts
        erb :'control_panels/accounts/index'
      end

      get '/control_panel/accounts/new' do
        halt 401 unless current_user.is_admin?
        erb :'control_panels/accounts/new'
      end

    end
  end
end
