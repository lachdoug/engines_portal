class V0
  module Api
    module Controllers

      get '/control_panel/shortcuts/engines_app/new' do

        @shortcut = Shortcut.new shortcut_type: :engines_app
        erb :'control_panels/shortcuts/engines_apps/new'
      end

      # post '/control_panel/shortcuts/engines_app/new' do
      #
      #   @shortcut = Shortcut.new params[:shortcut]
      #   @shortcut.load_app_label_from system
      #   @shortcut.load_app_websites_from system
      #   erb :'control_panels/shortcuts/engines_apps/form'
      # end

      post '/control_panel/shortcuts/engines_app' do

        @shortcut = Shortcut.new params[:shortcut]
        @shortcut.load_defaults_from system
        if @shortcut.save
          @icon_uploader = @shortcut.icon_uploader
          if @icon_uploader.update_from_default
            redirect "/control_panel/shortcuts/#{ @shortcut.id }"
          else
            redirect "/control_panel/shortcuts/#{ @shortcut.id }", alert: "Failed to load icon."
          end
        else
          redirect "/control_panel/shortcuts", alert: "Failed to create shortcut."
        end
      end

      get '/control_panel/shortcuts/:id/engines_app/edit' do

        @shortcut = Shortcut.find params[:id]
        @shortcut.load_app_websites_from system
        erb :'control_panels/shortcuts/engines_apps/form'
      end

      post '/control_panel/shortcuts/:id/engines_app' do

        @shortcut = Shortcut.find params[:id]
        if @shortcut.update params[:shortcut]
          redirect "/control_panel/shortcuts/#{ @shortcut.id }"
        else
          erb :'control_panels/shortcuts/engines_apps/form'
        end
      end



    end
  end
end
