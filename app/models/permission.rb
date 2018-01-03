class Permission < ApplicationRecord
  enum name: {
    a: 0,
    b: 1,
    c: 2,
    d: 3
  }.freeze

  has_many :permission_associations, dependent: :destroy
  has_many :permission_groups, through: :permission_associations
end
