class V0
  module Api
    module Controllers

      get '/control_panel/shortcuts/:id/icon/engines_app/edit' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find params[:id]
        @shortcut.load_default_icon_url_from system
        erb :'control_panels/shortcuts/icons/engines_apps/show'
      end

      post '/control_panel/shortcuts/:id/icon/engines_app/update' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find params[:id]
        @shortcut.load_default_icon_url_from system
        @icon_uploader = @shortcut.icon_uploader
        if @icon_uploader.update_from_default
          redirect "/control_panel/shortcuts/#{ params[:id] }/icon"
        else
          redirect "/control_panel/shortcuts/#{ params[:id] }/icon", alert: "Failed to load icon."
        end
      end

    end
  end
end
