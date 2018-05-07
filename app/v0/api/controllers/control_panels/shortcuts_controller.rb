class V0
  module Api
    module Controllers

      get '/control_panel/shortcuts' do
        halt 401 unless current_user.is_admin?
        @shortcuts = Shortcut.all
        erb :'control_panels/shortcuts/index'
      end

      get '/control_panel/shortcuts/new' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.new( shortcut_type: :link )
        erb :'control_panels/shortcuts/form'
      end

      get '/control_panel/shortcuts/:id' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/show'
      end

      post '/control_panel/shortcuts' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.new( params[:shortcut] )
        if @shortcut.save
          redirect "/control_panel/shortcuts/#{ @shortcut.id }"
        else
          erb :'control_panels/shortcuts/form'
        end
      end

      get '/control_panel/shortcuts/:id/edit' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/form'
      end

      post '/control_panel/shortcuts/:id' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find( params[:id] )
        if @shortcut.update( params[:shortcut] )
          redirect "/control_panel/shortcuts/#{ @shortcut.id }"
        else
          erb :'control_panels/shortcuts/form'
        end
      end

      delete '/control_panel/shortcuts/:id' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find( params[:id] )
        if @shortcut.delete
          redirect "/control_panel/shortcuts"
        else
          erb :'control_panels/shortcuts/show'
        end
      end

      get '/control_panel/shortcuts/:id/delete' do
        halt 401 unless current_user.is_admin?
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/delete'
      end



    end
  end
end
