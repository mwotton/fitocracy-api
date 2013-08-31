require 'fitocracy/paths'

module Fitocracy
  class Login
    attr_accessor :x_fitocracy_user
    def initialize(agent)
      @agent = agent
    end

    def login(user, password)
      print [user,password].inspect
      res = @agent.post(::Fitocracy::Paths.login_uri, form_values(user,password))
      body = JSON.parse(res.body)
      print body
      raise "invalid credentials" unless body['success'] == true
      res.response['x-fitocracy-user']
    end

    private

    def form_values(user,password)
      {
        'csrfmiddlewaretoken' => login_form['csrfmiddlewaretoken'],
        'is_username'         => '1',
        'json'                => '1',
        'next'                => '/home/',
        'username'            => user,
        'password'            => password
      }
    end

    def login_form
      login_page = @agent.get(::Fitocracy::Paths.login_uri)

      login_page.form_with(:id => 'username-login-form')
    end

  end
end
