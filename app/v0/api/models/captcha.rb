require 'fileutils'

class Captcha

  include Sinatra::Security

  def initialize( session, settings )
    @session = session
    @settings = settings
  end

  def dirname
    "/tmp/captchas"
  end

  def filename
    "#{ dirname }/#{ @session[:session_id] }.png"
  end

  def image
    image = File.read( filename ) if File.exist?( filename )
    File.delete( filename )
    image
  end

  def try( attempt )
    raise V0::NonFatalError.new( "Captcha failed", 405 ) unless
      @session[:captcha].length > 0 &&
      attempt.length > 0 &&
      Password::Hashing.check( attempt.downcase, @session[:captcha] )
  end

  def generate_challenge
    answer = generate_answer
    @session[:captcha] = Password::Hashing.encrypt( answer )
    FileUtils.mkdir_p dirname
    File.open( filename, 'w+' ).write( generate_image answer )
  end

  def generate_answer
    chars = (('2'..'8').to_a + ('a'..'z').to_a - ['o', 'd', 'l', 'g', 'q', 'm', 'n', 'h', 'i', 'j', 'u', 'e', 's', 't', 'r', '5', '7', '8']) #* 3
    chars = chars.sort_by { rand }
    chars[ 0 .. ( @settings.captcha_length.to_i - 1 ) ].join.to_s
  end

  def generate_image(string)
      options = {
        fontsize: 60,
        width: 300,
        height: 125,
        color: '#000',
        background: '#FFF',
        fontweight: 700,
        rotate: true,
        fonts: ['FreeMono', 'FreeSerif', 'FreeSans']
      }

      text = Magick::Draw.new
      text.pointsize = options[:fontsize] + rand(5)
      text.font_weight = options[:fontweight]
      text.gravity = Magick::CenterGravity
      text.fill = text.stroke = 'white'
      text.font = options[:fonts].sort_by{rand}.first if options[:fonts]
      text.text_antialias = false
      text.rotation = (5 + rand(5)) * (rand() < 0.5 ? 1:-1) if options[:rotate]

      canvas = Magick::ImageList.new
      gradient = Magick::GradientFill.new(0, 0, -10 + rand(20), -10 + rand(20), "rgb(#{255-rand(70)},#{255-rand(10)},255-#{rand(50)})", "##{rand(7)}#{rand(6)}#{rand(5)+3}")
      bg_image = Magick::Image.new(options[:width], options[:height], gradient)
      dc = Magick::Draw.new
      dc.stroke("black")
      dc.stroke_width(30)
      r = rand(90)
      dc.line(-10, r, options[:width]+10, 90-r)
      dc.draw(bg_image)

      text_image = Magick::Image.new(options[:width], options[:height]){
        self.background_color = '#48D'
      }.annotate(text, 0, 0, 0, -10, string).implode(-0.1).wave(5 + rand(5), 60 + rand(20))

      canvas << bg_image.composite(text_image,0,0,Magick::DifferenceCompositeOp)

      image = canvas.flatten_images.blur_image(1)
      image.format = 'PNG'
      image.to_blob{ self.quality = 30 }
  end

end
