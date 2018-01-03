class PermissionAssociation < ApplicationRecord
  belongs_to :permission
  belongs_to :permission_group
end
