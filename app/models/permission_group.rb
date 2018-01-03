class PermissionGroup < ApplicationRecord
  has_many :permission_associations, dependent: :destroy
  has_many :permissions, through: :permission_associations
  has_many :user_permission_groups, dependent: :destroy
  has_many :users, through: :user_permission_groups
end
