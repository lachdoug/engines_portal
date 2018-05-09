class V0
  module Api
    module Controllers

      get '/control_panel/shortcuts/link/new' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.new( shortcut_type: :link )
        erb :'control_panels/shortcuts/links/form'
      end

      post '/control_panel/shortcuts/link' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.new( params[:shortcut] )
        if @shortcut.save
          redirect "/control_panel/shortcuts/#{ @shortcut.id }"
        else
          erb :'control_panels/shortcuts/links/form'
        end
      end

      get '/control_panel/shortcuts/:id/link/edit' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/links/form'
      end

      post '/control_panel/shortcuts/:id/link' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find( params[:id] )
        if @shortcut.update( params[:shortcut] )
          redirect "/control_panel/shortcuts/#{ @shortcut.id }"
        else
          erb :'control_panels/shortcuts/links/form'
        end
      end



    end
  end
end
