class V0
  module Api
    module Controllers

      get '/control_panel/shortcuts/:id/accounts' do
        @shortcut = Shortcut.find( params[:id] )
        erb :'control_panels/shortcuts/accounts/show'
      end

      post '/control_panel/shortcuts/:id/accounts' do
        @shortcut = Shortcut.find( params[:id] )
        @shortcut.account_shortcuts.create params[:account_shortcut]
        redirect "/control_panel/shortcuts/#{ @shortcut.id }/accounts"
      end

      delete '/control_panel/account_shortcuts/:id' do
        @account_shortcut = AccountShortcut.find( params[:id] )
        @account_shortcut.delete
        redirect "/control_panel/shortcuts/#{ @account_shortcut.shortcut_id }/accounts"
      end

      #
      # post '/control_panel/shortcuts/link' do
      #
      #   @shortcut = Shortcut.new( params[:shortcut] )
      #   if @shortcut.save
      #     redirect "/control_panel/shortcuts/#{ @shortcut.id }"
      #   else
      #     erb :'control_panels/shortcuts/links/form'
      #   end
      # end
      #
      # get '/control_panel/shortcuts/:id/link/edit' do
      #
      #   @shortcut = Shortcut.find( params[:id] )
      #   erb :'control_panels/shortcuts/links/form'
      # end
      #
      # post '/control_panel/shortcuts/:id/link' do
      #
      #   @shortcut = Shortcut.find( params[:id] )
      #   if @shortcut.update( params[:shortcut] )
      #     redirect "/control_panel/shortcuts/#{ @shortcut.id }"
      #   else
      #     erb :'control_panels/shortcuts/links/form'
      #   end
      # end



    end
  end
end
