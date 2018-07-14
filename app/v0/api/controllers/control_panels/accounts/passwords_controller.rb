class V0
  module Api
    module Controllers

      get '/control_panel/accounts/password/edit' do
        @account = system.accounts.find( params[:uid] )
        if @account.is_administrator?
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }",
           alert: "Can't change the password "\
                  "of an account that is a member of the "\
                  "administrators group."
        else
          erb :'control_panels/accounts/passwords/edit'
        end
      end

      post '/control_panel/accounts/password' do
        @account = system.accounts.find( params[:uid] )
        begin
          @account.change_password( params[:account][:password] )
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
        rescue V0::NonFatalError
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }", alert: "Failed to update password."
        end
      end

    end
  end
end
