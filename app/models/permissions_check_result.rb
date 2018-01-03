class PermissionsCheckResult < ApplicationRecord
  # this guarantees the enum values are the same as those used in Permission model
  enum permission_name: Permission.names.freeze

  # class method for checking whether a particular user has all of the given permissions
  def self.user_has_permissions?(user, *permissions)
    PermissionsCheckResult.where(user_id: user.id, permission_name: permissions)
    .group(:user_id)
    .having('COUNT(permission_name) = ?', permissions.count)
    .exists?
  end

  # View refreshing scheduling. Read more about it on scenic’s page.
  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end

  private

  # This makes sure ActiveRecord won’t try to save anything using this model.
  def readonly?
    true
  end
end
