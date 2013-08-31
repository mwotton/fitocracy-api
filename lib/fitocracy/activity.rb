require 'fitocracy/base'
module Fitocracy
  class Activity
    def initialize(hash={})
      @user          = hash[:user]
      @agent         = hash[:agent]
      @activity_name = hash[:activity_name]
    end

    def get_all_activities_for_user
      @activities ||= @agent.get(Paths.activities_uri(@user.x_fitocracy_user))
    end

    def get_activity_data
      @activity = JSON.parse(@activities.body) \
                      .detect {|activity| activity["name"] == @activity_name}
    end

    def activity_log
      get_all_activities_for_user
      get_activity_data

      @agent.get(::Fitocracy::Paths.activity_history_uri(@activity['id']))
    end

    protected
    def history_path
      "get_history_json_from_activity/#{@id}/?max_sets=-1&max_workouts=-1&reverse=1"
    end

  end
end
