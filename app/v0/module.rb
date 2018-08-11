require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'sinatra/security'
require 'rest-client'
require 'byebug' # if Sinatra::Base.development?
require "sinatra/activerecord"

class V0 < Sinatra::Base

  # set :database, {adapter: "sqlite3", database: "db.sqlite3"}
  register Sinatra::ActiveRecordExtension

  ## For debugging
  ##----------------------------------------------------------------------------

  before do
    if Sinatra::Base.development?
      puts 'Request'
      puts request.request_method
      puts request.path_info
      puts params.inspect
    end
  end


  ##############################################################################
  ## Settings
  ##############################################################################

  if Sinatra::Base.development?
    ENV['ENGINES_USER_PORTAL_SYSTEM_IP'] = "172.16.162.128"
    ENV['ENGINES_USER_PORTAL_SESSION_SECRET'] = 'nosecret'
  end

  set system_ip: ENV['ENGINES_USER_PORTAL_SYSTEM_IP']
  set dump_errors: true # Sinatra::Base.development?
  set public_folder: 'public'
  set session_secret: ENV['ENGINES_USER_PORTAL_SESSION_SECRET'] || ENV['SECRET_KEY_BASE']
  set user_inactivity_timeout: ( ENV['ENGINES_USER_PORTAL_USER_INACTIVITY_TIMEOUT'] || 30 ).to_f * 60
  set no_admin: ENV['ENGINES_USER_PORTAL_DISABLE_ADMIN'] == 'true'
  set no_captcha: ENV['ENGINES_USER_PORTAL_DISABLE_CAPTCHA'] == 'true'
  set captcha_length: ( ENV['ENGINES_USER_PORTAL_CAPTCHA_LENGTH'] || 4 ).to_i

  ## support _method DELETE/PUT
  use Rack::MethodOverride

  ##############################################################################
  ## CLIENT
  ##############################################################################

  def application_js_files
    Dir.glob( [ "#{self.class.root}/views/assets/javascript/**/*.js" ] ).map do |file|
      File.read file
    end.join("\n")
  end

  def application_css_files
    Dir.glob( [ "#{self.class.root}/views/assets/css/**/*.css" ] ).map do |file|
      File.read file
    end.join("\n")
  end

  ##############################################################################
  ## Errors
  ##############################################################################

  class NonFatalError < StandardError
    def initialize(message, status_code=500)
      @message = message
      @status_code = status_code
    end
    attr_reader :status_code, :message
  end

  ##############################################################################
  ## API
  ##############################################################################

  ## Load-up the controllers, models & services
  ##----------------------------------------------------------------------------

  require_relative 'api/api'
  register Api::Controllers

  ## Helpers
  ##----------------------------------------------------------------------------

  helpers Api::Helpers


  ## ERB
  ##----------------------------------------------------------------------------

  def redirect(route, opts={})
    session[:flash] =
      if opts[:notice]
        { notice: opts[:notice] }
      elsif  opts[:alert]
        { alert: opts[:alert] }
      end
      # byebug
    super route
  end

  # def session
  #   byebug
  #   super
  # end

  def flash
    # byebug
    return @flash if @flash
    @flash = session[:flash] || {}
    session[:flash] = nil
    @flash
  end

  ## Navbar
  ##----------------------------------------------------------------------------

  def navbar
    erb :navbar
  end

  ## Authenticate
  ##----------------------------------------------------------------------------

  enable :sessions

  before do
    begin
      no_auth? || authenticate_user
      halt 401 if is_control_panel? && ( settings.no_admin? || !current_user.is_admin? )
      # byebug
    # rescue NonFatalError => e
    #   redirect '/sign_in', alert: e.message
    end
  end

  def is_control_panel?
    request.path_info.split("/")[1] == "control_panel"
  end

  def no_auth?
    request.path_info == '/' ||
    request.path_info == '/sign_in' ||
    request.path_info == '/captcha' ||
    request.path_info == '/user/password/success'
  end

  def system_api_token
    current_user.system_api_token if current_user
  end

  def system_ip
    settings.system_ip
  end

  def system_api_url
    "https://#{system_ip}:2380"
  end

  attr_reader :current_user

  def authenticate_user
    user = Api::Models::User.new session, request, settings
    if user.authenticated?
      @current_user = user
    else
      session.clear
      @current_user = nil
    end
  end

  # def clear_current_user
  #
  # end

  ## Set core resources
  ##----------------------------------------------------------------------------

  def system(opts={})
      Api::Models::System.new(
        system_api_url,
        opts[:without_token] ? nil : system_api_token,
        settings,
        session )
  end


  ## View helpers
  helpers do
        def fa( type, text=nil )
          "<i class='fa fa-#{type}'></i>#{ text ? ' ' + text : nil }"
        end
  end

  # ## Error handling
  # ##----------------------------------------------------------------------------
  #
  # ## 400 Fatal: General client error
  # ## 401 Non-fatal: Authentication failed
  # ## 404 Fatal: Bad route
  # ## 405 Non-fatal: Action not allowed (route is recognised, but action cannot be performed)
  # ## 406 Fatal: Params not acceptable (route is recognised, but params incomplete or invalid)
  # ## 500 Fatal: General server error
  # ## 503 Non-fatal: System busy or unavailable

  set show_exceptions: false

  error do |error|
    content_type :json
    if error.is_a?(NonFatalError)
      if error.status_code == 401
        redirect '/sign_in', alert: error.message
      else
        redirect '/user/portal', alert: error.message
      end
    else
      [ 500, { error: {
        message: "Server error.", detail: fatal_error_detail( error )
      } }.to_json ]
    end
  end

  def fatal_error_detail( error )
    error_text = error.class.to_s + " (" + error.message + ")"
    if error.respond_to?(:response) && error.response.respond_to?(:net_http_res) && !error.response.net_http_res.body.empty?
      response = JSON.parse(error.response.net_http_res.body, symbolize_names: true)
      system_error = response[:error_object] || response[:error]
      system_error_message = system_error[:error_mesg] || system_error[:message]
      error_text += "\n\n#{system_error_message}"
    end
    {
        application: "Portal ApiV0 v0.1",
        type: :Server500,
        text: error_text,
        method: request.request_method,
        path: request.fullpath,
        backtrace: error.backtrace,
    }
  end

  not_found do
    404
  end



end
