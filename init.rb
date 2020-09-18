require 'redmine'

Redmine::Plugin.register :redmine_user_profile_hide do
  name 'Redmine Hidden User Profile plugin'
  author 'Eugene dubinin <eugend@commandprompt.com>'
  author_url 'https://www.commandprompt.com'
  description 'Adds a permission to view user profile. Hides project members box, delinkifies user profile links and disables the user profile page.'
  version '0.2.0'
  url 'https://github.com/commandprompt/redmine_hidden_user_profile'

  permission :view_user_profiles, :users => :show
end


prepare_block = Proc.new do
  ApplicationHelper.send(:include, RedmineUserProfileHide::ApplicationHelperPatch)
  UsersController.send(:include, RedmineUserProfileHide::UsersControllerPatch)
end

if Rails.env.development?
  ((Rails.version > "5")? ActiveSupport::Reloader : ActionDispatch::Callbacks).to_prepare { prepare_block.call }
else
  prepare_block.call
end
