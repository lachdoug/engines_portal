class V0
  module Api
    module Models
      class Shortcut < ActiveRecord::Base
        class IconUploader

          require 'rmagick'

          def initialize(shortcut)
            @shortcut = shortcut
          end

          def update(icon)
            if icon && icon[:file]
              FileUtils.mkdir_p('data/v0/icons') unless Dir.exist? 'data/v0/icons'
              image = Magick::Image.read(icon[:file][:tempfile].path)[0]
              image.resize_to_fit! 256, 256
              image.write("data/v0/icons/#{@shortcut.id}")
            end
          rescue Magick::ImageMagickError
            return false
          end

        end
      end
    end
  end
end
