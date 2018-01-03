Permission.names.keys.each do |name|
  Permission.find_or_create_by!(name: name)
end
n_permission_groups = 10
n_permissions_in_group = 5
n_permission_groups.times do
  PermissionGroup.create!(
    permissions: Permission.order('RANDOM()').limit(n_permissions_in_group)
  )
end

n_users = 100
n_permission_groups_in_users = 3
n_users.times do
  User.create!(permission_groups: PermissionGroup.order('RANDOM()').limit(n_permission_groups_in_users))
end
