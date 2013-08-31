# require 'fitocracy'
require 'active_resource'
module Fitocracy
  class Base < ActiveResource::Base
    self.site = "https://www.fitocracy.com"
  end
end
