class V0
  module Api
    module Controllers

      get '/control_panel' do
        halt 401 unless current_user.is_admin?
        erb :'control_panels/show'
      end

    end
  end
end
