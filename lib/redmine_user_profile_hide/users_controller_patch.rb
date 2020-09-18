module RedmineUserProfileHide
  module UsersControllerPatch
    unloadable

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        before_action :check_hidden_permission, :only => [:show]

        def check_hidden_permission
          return true if User.current.id == request[:id].to_i
          unless User.current.admin || User.current.allowed_to?(:view_user_profiles, @project, :global => true)
            render_403
          end
        end
      end
    end
  module InstanceMethods
  end
  end
end