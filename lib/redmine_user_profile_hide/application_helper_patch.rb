module RedmineUserProfileHide
  module ApplicationHelperPatch
    unloadable

    def self.included(base)
      base.class_eval do

        def link_to_user(user, options={})
          if (User.current.admin || User.current.allowed_to?(:view_user_profiles, @project, :global => true) || User.current == user) && user.is_a?(User)
            name = h(user.name(options[:format]))
            if user.active? || (User.current.admin? && user.logged?)
              link_to name, user_path(user), :class => user.css_classes
            else
              name
            end
          else
            h(user.to_s)
          end
        end

      end
    end

  end
end