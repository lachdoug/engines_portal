class V0
  module Api
    module Controllers

      get '/control_panel/accounts/email/aliases/add/new' do
        @account = system.accounts.find( params[:uid] )
        @aliases = @account.email.aliases
        erb :'control_panels/accounts/emails/aliases/adds/new'
      end

      post '/control_panel/accounts/email/aliases/add' do
        @account = system.accounts.find( params[:uid] )
        @aliases = @account.email.aliases
        begin
          @aliases.add params[:email_alias]
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
        rescue => e
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }", alert: "Failed to create email alias."
        end
      end

    end
  end
end
