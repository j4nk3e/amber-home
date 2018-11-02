require "jasper_helpers"
require "adamite"

class ApplicationController < Amber::Controller::Base
  include JasperHelpers
  LAYOUT = "application.slang"
end
