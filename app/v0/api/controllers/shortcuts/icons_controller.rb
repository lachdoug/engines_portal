class V0
  module Api
    module Controllers

      get '/shortcuts/:id/icon' do
        send_file File.open( "data/v0/icons/#{params[:id]}" ),
          disposition: 'inline'
      end

    end
  end
end
