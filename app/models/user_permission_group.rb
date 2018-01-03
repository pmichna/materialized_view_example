class UserPermissionGroup < ApplicationRecord
  belongs_to :user
  belongs_to :permission_group
end
