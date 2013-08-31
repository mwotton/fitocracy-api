require 'fitocracy/base'
require 'fitocracy/login'
module Fitocracy
  class User < Fitocracy::Base

#    has_many :activities

    # include ::Fitocracy::Paths

    attr_reader :username, :password
    attr_accessor :x_fitocracy_user, :agent, :error

    def initialize(hash)
      @username = hash[:username] || ENV['fitocracy_api_username']
      @password = hash[:password] || ENV['fitocracy_api_password']
      @agent    = hash[:agent] || Mechanize.new
      validate_user
    end

    def activities
      print "i am: #{@x_fitocracy_user}"
      @activities ||= JSON.parse(@agent.get(Paths.activities_uri(@x_fitocracy_user)).body)
    end

    private

    def validate_user
      @error ||= 'Username is missing' if username.empty?
      @error ||= 'Password is missing' if password.empty?
      @x_fitocracy_user ||= Login.new(@agent).login(@username, @password)
    end



  end
end
