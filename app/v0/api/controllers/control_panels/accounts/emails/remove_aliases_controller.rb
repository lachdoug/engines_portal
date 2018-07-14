class V0
  module Api
    module Controllers

      get '/control_panel/accounts/email/aliases/remove/new' do
        @account = system.accounts.find( params[:uid] )
        @aliases = @account.email.aliases
        erb :'control_panels/accounts/emails/aliases/removes/new'
      end

      post '/control_panel/accounts/email/aliases/remove' do
        @account = system.accounts.find( params[:uid] )
        @aliases = @account.email.aliases
        @aliases.remove params[:email_alias]
        redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
      end

    end
  end
end
