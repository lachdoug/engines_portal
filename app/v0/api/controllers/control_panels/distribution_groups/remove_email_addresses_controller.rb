class V0
  module Api
    module Controllers

      get '/control_panel/distribution_groups/remove/new' do
        @distribution_group = system.distribution_groups.find( params[:name] )
        erb :'control_panels/distribution_groups/removes/new'
      end

      post '/control_panel/distribution_groups/remove' do
        @distribution_group = system.distribution_groups.find( params[:name] )
        begin
          @distribution_group.remove params[:address]
          redirect "/control_panel/distribution_groups/?name=#{ params[:name] }"
        rescue V0::NonFatalError
          redirect "/control_panel/distribution_groups/?name=#{ params[:name] }", alert: "Failed to remove email address."
        end
      end

    end
  end
end
