class V0
  module Api
    module Controllers

      get '/' do
        begin
          authenticate_user
          redirect '/user/portal'
        rescue NonFatalError => e
          redirect '/sign_in' if e.status_code == 401
          raise
        end
      end

    end
  end
end
