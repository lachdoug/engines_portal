# class V0
#   module Api
#     module Models
#       class FlashMessage
#           def initialize(session)
#               @session ||= session
#           end
#
#           def message=(message)
#               @session[:flash] = message
#           end
#
#           def message
#               message = @session[:flash] #tmp get the value
#               @session[:flash] = nil # unset the value
#               message # display the value
#           end
#       end
#     end
#   end
# end
#
