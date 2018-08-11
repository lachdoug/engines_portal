class V0
  module Api
    module Controllers

      get '/captcha' do
        @captcha = Captcha.new( session, settings )
        content_type 'application/octet-stream'
        @captcha.image
      end

    end
  end
end
