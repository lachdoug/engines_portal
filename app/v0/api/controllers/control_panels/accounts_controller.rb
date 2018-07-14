class V0
  module Api
    module Controllers

      get '/control_panel/accounts' do
        @accounts = system.accounts.index
        erb :'control_panels/accounts/index'
      end

      get '/control_panel/accounts/new' do
        erb :'control_panels/accounts/new'
      end

      get '/control_panel/accounts/' do
        @account = system.accounts.find( params[:uid] )
        erb :'control_panels/accounts/show'
      end

      post '/control_panel/accounts' do
        @account = system.accounts.create params[:account]
        redirect "/control_panel/accounts/?uid=#{ params[:account][:uid] }"
      end

      delete '/control_panel/accounts/' do
        @account = system.accounts.find( params[:uid] )
        if @account.groups.empty? && @account.email.disabled?
          begin
            @account.delete
            redirect "/control_panel/accounts"
          rescue V0::NonFatalError
            redirect "/control_panel/accounts/?uid=#{ params[:uid] }", alert: "Failed to delete account."
          end
        else
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }",
           alert: "Can't delete "\
                  "account when groups are present or "\
                  "email is enabled."
        end
      end

    end
  end
end
