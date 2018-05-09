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
            file.write open( @shortcut.default_icon_url ).read
            save_image_from file.path
          end

          def save_image_from( filepath )
            FileUtils.mkdir_p('data/v0/icons') unless Dir.exist? 'data/v0/icons'
            image = Magick::Image.read(filepath)[0]
            image.resize_to_fit! 256, 256
            image.write("data/v0/icons/#{@shortcut.id}")
          end

        end
      end
    end
  end
end
