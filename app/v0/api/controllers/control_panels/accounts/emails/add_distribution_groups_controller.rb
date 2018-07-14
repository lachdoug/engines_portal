class V0
  module Api
    module Controllers

      get '/control_panel/accounts/email/distribution_groups/add/new' do
        @account = system.accounts.find( params[:uid] )
        @distribution_groups = @account.email.distribution_groups
        erb :'control_panels/accounts/emails/distribution_groups/adds/new'
      end

      post '/control_panel/accounts/email/distribution_groups/add' do
        @account = system.accounts.find( params[:uid] )
        @distribution_groups = @account.email.distribution_groups
        @distribution_groups.add params[:distribution_group]
        redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
      end

    end
  end
end
