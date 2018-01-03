class User < ApplicationRecord
  has_many :user_permission_groups, dependent: :destroy
  has_many :permission_groups, through: :user_permission_groups
end
