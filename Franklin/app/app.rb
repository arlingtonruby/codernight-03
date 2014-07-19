# We bootstrap before defining the app class so that the application has
# access to all of the config and initialization data.
# This works well, except for the fact that I'd love to use App.logger
# during initialization.  Perhaps the logger could be pulled out
# of App and created beforehand.
require File.expand_path('app/bootstrap')
require 'logger'


# Define our base Application Class
class App
  # The logger stuff is here for your use. Please implement some
  # good logging practices for your application.
  @@logger = Logger.new(File.expand_path(Global.logging.file))
  @@logger.level = Logger.const_get(Global.logging.level.upcase)

  def self.logger
    @@logger
  end

  def solve(iterations, cave)
    iterations.times do
      cave = CaveWaterFiller.fill(cave)
      yield
    end
    cave
  end
end