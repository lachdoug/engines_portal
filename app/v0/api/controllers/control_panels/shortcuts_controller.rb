class V0
  module Api
    module Controllers

      get '/control_panel/shortcuts' do
        @shortcuts = Shortcut.all.sort_by { |shortcut| shortcut.label.downcase }
        erb :'control_panels/shortcuts/index'
      end

      get '/control_panel/shortcuts/new' do
        @shortcut = Shortcut.new( shortcut_type: :link )
        erb :'control_panels/shortcuts/new'
      end

      get '/control_panel/shortcuts/:id' do
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/show'
      end

      delete '/control_panel/shortcuts/:id' do
        @shortcut = Shortcut.find( params[:id] )
        if @shortcut.destroy
          redirect "/control_panel/shortcuts"
        else
          erb :'control_panels/shortcuts/show'
        end
      end

      get '/control_panel/shortcuts/:id/delete' do
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/delete'
      end

    end
  end
end
