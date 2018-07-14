class V0
  module Api
    module Controllers

      post '/control_panel/shortcuts/:id/accounts/all' do
        @shortcut = Shortcut.find( params[:id] )
        @shortcut.update( all_accounts: true )
        redirect to "/control_panel/shortcuts/#{ params[:id] }/accounts"
      end

      delete '/control_panel/shortcuts/:id/accounts/all' do
        @shortcut = Shortcut.find( params[:id] )
        @shortcut.update( all_accounts: false )
        redirect to "/control_panel/shortcuts/#{ params[:id] }/accounts"
      end

    end
  end
end
