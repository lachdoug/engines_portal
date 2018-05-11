class V0
  module Api
    module Models
      class Shortcut < ActiveRecord::Base
        class IconUploader

          require 'rmagick'
          require "open-uri"

          def initialize(shortcut)
            @shortcut = shortcut
          end

          def update(icon)
            if icon && icon[:file]
              save_image_from icon[:file][:tempfile].path
            end
          rescue Magick::ImageMagickError
            return false
          end

          def update_from_default
            file = Tempfile.new('icon_image')
            # byebug
            file.write open( @shortcut.default_icon_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE ).read
            save_image_from file.path
          rescue Errno::ENOENT # no file
            false
          end

          def save_image_from( filepath )
            FileUtils.mkdir_p('data/v0/icons') unless Dir.exist? 'data/v0/icons'
            image = Magick::Image.read(filepath)[0]
            image.resize_to_fit! 256, 256
            image.write("data/v0/icons/#{@shortcut.id}")
          rescue Magick::ImageMagickError
            false
          end

        end
      end
    end
  end
end
