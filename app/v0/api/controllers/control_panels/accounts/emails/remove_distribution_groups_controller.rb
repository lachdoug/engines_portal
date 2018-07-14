class V0
  module Api
    module Controllers

      get '/control_panel/accounts/email/distribution_groups/remove/new' do
        @account = system.accounts.find( params[:uid] )
        @distribution_groups = @account.email.distribution_groups
        erb :'control_panels/accounts/emails/distribution_groups/removes/new'
      end

      post '/control_panel/accounts/email/distribution_groups/remove' do
        @account = system.accounts.find( params[:uid] )
        @distribution_groups = @account.email.distribution_groups
        distribution_group_name, email_address = params[:distribution_group_name_and_email_address].split(':')
        @distribution_groups.remove distribution_group_name, email_address
        redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
      end

    end
  end
end
