require 'fitocracy/paths'
module Fitocracy
  class User < Base

    has_many :activities

    # include ::Fitocracy::Paths

    attr_reader :username, :password
    attr_accessor :x_fitocracy_user, :agent, :error

    def initialize(hash={})
      @username = hash[:username] || ENV['fitocracy_api_username']
      @password = hash[:password] || ENV['fitocracy_api_password']
      @agent    = hash[:agent]

      validate_user
    end

    def activities
      @activities ||= JSON.parse(@agent.get(Paths.activities_uri(ex_fitocracy_user)).body)
    end

    private

    def validate_user
      @error ||= 'Username is missing' if username.empty?
      @error ||= 'Password is missing' if password.empty?
    end
  end
end
