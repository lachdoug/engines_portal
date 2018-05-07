class V0
  module Api

    module Models; end
    module Services; end
    module Helpers; end

    Dir.glob( [ "./app/v0/api/models/**/*.rb" ] ).each { |file| require file }
    Dir.glob( [ "./app/v0/api/services/**/*.rb" ] ).each { |file| require file }
    Dir.glob( [ "./app/v0/api/helpers/**/*.rb" ] ).each { |file| require file }

    module Controllers
      include Models
      include Services
      extend Sinatra::Extension
      Dir.glob( [ "./app/v0/api/controllers/**/*.rb" ] ).each { |file| require file }
    end

  end
end
