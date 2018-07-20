class V0
  module Api
    module Controllers

      get '/control_panel/groups' do
        @groups = system.groups.index
        erb :'control_panels/groups/index'
      end

      get '/control_panel/groups/' do
        @group = system.groups.find( params[:dn] )
        erb :'control_panels/groups/show'
      end

    end
  end
end
