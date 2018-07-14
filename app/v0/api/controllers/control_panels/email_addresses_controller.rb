class V0
  module Api
    module Controllers

      get '/control_panel/email_addresses' do
        @email_addresses = system.email_addresses
        erb :'control_panels/email_addresses/index'
      end

    end
  end
end
