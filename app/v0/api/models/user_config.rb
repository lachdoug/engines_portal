class V0
  module Api
    module Models
      class UserConfig

        attr_reader :username

        def initialize( username, settings )
          @username = username
          FileUtils.touch "#{@settings.data_directory_path}/user_config.json"
        end

        def save_config
          File.write "#{@settings.data_directory_path}/user_config.json",
           config.merge({ username => @config }).to_json
        end

        def update_config( config )
          @config = config
        end

        def config
          @config ||=
          begin
            File.read "#{@settings.data_directory_path}/current_user.json"
            JSON.parse ( config_file ), symbolize_names: true
          rescue
            {}
          end
        end


      end
    end
  end
end
