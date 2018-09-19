module RedmineHiddenUserProfile
  module UsersControllerPatch
    unloadable

    def self.included(base)
      base.class_eval do
        before_filter :check_hidden_permission, :only => [:show]

        def check_hidden_permission
          return true if User.current.id == request[:id].to_i
          unless User.current.admin || User.current.allowed_to?(:view_user_profiles, @project, :global => true)
            render_403
          end
        end
      end
    end

  end
end