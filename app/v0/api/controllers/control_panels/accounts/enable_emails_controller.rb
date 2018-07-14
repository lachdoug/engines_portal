class V0
  module Api
    module Controllers

      get '/control_panel/accounts/setup_email/new' do
        @account = system.accounts.find( params[:uid] )
        @setup_email = @account.setup_email
        erb :'control_panels/accounts/setup_emails/new'
      end

      post '/control_panel/accounts/setup_email' do
        @account = system.accounts.find( params[:uid] )
        @setup_email = @account.setup_email
        @setup_email.process( params[:setup_email] )
        redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
      end

      delete '/control_panel/accounts/setup_email' do
        @account = system.accounts.find( params[:uid] )
        if @account.email.distribution_groups.empty? && @account.email.aliases.empty?
          @setup_email = @account.setup_email
          begin
            @setup_email.disable
            redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
          rescue V0::NonFatalError
            redirect "/control_panel/accounts/?uid=#{ params[:uid] }", alert: "Failed to disable email."
          end
        else
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }",
           alert: "Can't disable email "\
                  "when alises or distribution groups "\
                  "are present."
        end
      end

    end
  end
end
