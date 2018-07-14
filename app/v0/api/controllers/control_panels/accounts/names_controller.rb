class V0
  module Api
    module Controllers

      get '/control_panel/accounts/name/edit' do
        @account = system.accounts.find( params[:uid] )
        if @account.is_administrator?
          redirect "/control_panel/accounts/?uid=#{ params[:uid] }",
           alert: "Can't change the name "\
                  "of an account that is a member of the "\
                  "administrators group."
        else
          @name = @account.name
          erb :'control_panels/accounts/names/edit'
        end
      end

      post '/control_panel/accounts/name' do

        @account = system.accounts.find( params[:uid] )
        @name = @account.name
        @name.update( params[:name] )
        redirect "/control_panel/accounts/?uid=#{ params[:uid] }"
      end

    end
  end
end
