class V0
  module Api
    module Controllers

      # get '/control_panel/shortcuts/:id/icon' do
      #   @shortcut = Shortcut.find( params[:id] )
      #   erb :'control_panels/shortcuts/icons/show'
      # end

      get '/control_panel/shortcuts/:id/icon/edit' do
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/icons/form'
      end

      # get '/control_panel/shortcuts/:id/icon/delete' do
      #
      #   @shortcut = Shortcut.find( params[:id] )
      #   erb :'control_panels/shortcuts/icons/delete'
      # end

      delete '/control_panel/shortcuts/:id/icon' do

        Shortcut.find( params[:id] ).delete_icon
        redirect "/control_panel/shortcuts/#{ params[:id] }"
      end

      post '/control_panel/shortcuts/:id/icon' do

        @shortcut = Shortcut.find( params[:id] )
        @icon_uploader = @shortcut.icon_uploader
        if @icon_uploader.update( params[:icon] )
          redirect "/control_panel/shortcuts/#{ params[:id] }"
        else
          redirect "/control_panel/shortcuts/#{ params[:id] }", alert: "Failed to upload icon."
        end
      end

    end
  end
end
