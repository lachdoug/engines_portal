class V0
  module Api
    module Controllers

      get '/control_panel/shortcuts/:id/icon/system' do
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/icons/systems/show'
      end

      post '/control_panel/shortcuts/:id/icon/system/update' do
        # # byebug
        # halt 401 unless current_user.is_admin?
        # @shortcut = Shortcut.find( params[:id] )
        # @icon_uploader = @shortcut.icon_uploader
        # if @icon_uploader.update( params[:icon] )
        #   redirect "/control_panel/shortcuts/#{ params[:id] }/icon"
        # else
        #   erb :'control_panel/shortcuts/icons/form'
        # end
      end

    end
  end
end
