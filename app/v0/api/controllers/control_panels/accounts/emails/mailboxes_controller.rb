class V0
  module Api
    module Controllers

      get '/control_panel/accounts/email/mailbox/edit' do
        @account = system.accounts.find( params[:uid] )
        @mailbox = @account.email.mailbox
        erb :'control_panels/accounts/emails/mailboxes/edit'
      end

      post '/control_panel/accounts/email/mailbox' do
        @account = system.accounts.find( params[:uid] )
        @mailbox = @account.email.mailbox
        @mailbox.update( params[:mailbox] )
        redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
      end

    end
  end
end
