class V0
  module Api
    module Controllers

      get '/control_panel/distribution_groups/add/new' do
        @distribution_group = system.distribution_groups.find( params[:name] )
        @input = params[:input]
        erb :'control_panels/distribution_groups/adds/new'
      end

      post '/control_panel/distribution_groups/add' do
        @distribution_group = system.distribution_groups.find( params[:name] )
        begin
          @distribution_group.add params[:email_address]
          redirect "/control_panel/distribution_groups/?name=#{ params[:name] }"
        rescue V0::NonFatalError
          redirect "/control_panel/distribution_groups/?name=#{ params[:name] }", alert: "Failed to add email address."
        end
      end

    end
  end
end
