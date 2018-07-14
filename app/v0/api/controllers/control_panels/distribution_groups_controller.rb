class V0
  module Api
    module Controllers

      get '/control_panel/distribution_groups' do
        @distribution_groups = system.distribution_groups.index
        erb :'control_panels/distribution_groups/index'
      end

      get '/control_panel/distribution_groups/' do
        @distribution_group = system.distribution_groups.find params[:name]
        erb :'control_panels/distribution_groups/show'
      end

      get '/control_panel/distribution_groups/new' do
        @system_email = system.email
        erb :'control_panels/distribution_groups/new'
      end

      post '/control_panel/distribution_groups' do
        begin
          system.distribution_groups.create( params[:distribution_group] )
          redirect "/control_panel/distribution_groups/?name=#{
            params[:distribution_group][:local_part]}@#{
            params[:distribution_group][:domain]}"
        rescue V0::NonFatalError
          redirect "/control_panel/distribution_groups",
            alert: "Failed to create distribution group."
        end
      end

      get '/control_panel/distribution_groups/edit' do
        @distribution_group = system.distribution_groups.find params[:name]
        @system_email = system.email
        erb :'control_panels/distribution_groups/edit'
      end

      post '/control_panel/distribution_groups/' do
        @distribution_group = system.distribution_groups.find params[:name]
        @distribution_group.update params[:distribution_group]
        redirect "/control_panel/distribution_groups/?name=#{
          params[:distribution_group][:local_part]}@#{
          params[:distribution_group][:domain]}"
      end

      delete '/control_panel/distribution_groups/' do
        @distribution_group = system.distribution_groups.find params[:name]
        @distribution_group.delete
        redirect "/control_panel/distribution_groups"
      end

      get '/control_panel/distribution_groups/delete' do
        @distribution_group = system.distribution_groups.find params[:name]
        erb :'control_panels/distribution_groups/delete'
      end

    end
  end
end
