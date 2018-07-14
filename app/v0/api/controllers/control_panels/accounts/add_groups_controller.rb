class V0
  module Api
    module Controllers

      get '/control_panel/accounts/groups/add/new' do
        @account = system.accounts.find( params[:uid] )
        @groups = @account.groups
        erb :'control_panels/accounts/groups/adds/new'
      end

      post '/control_panel/accounts/groups/add' do
        @account = system.accounts.find( params[:uid] )
        @groups = @account.groups
        @groups.add params[:group_dns]
        redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
      end

    end
  end
end
