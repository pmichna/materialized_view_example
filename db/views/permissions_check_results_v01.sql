SELECT users.id AS user_id, permissions.name AS permission_name
FROM users
JOIN user_permission_groups ON user_permission_groups.user_id = users.id
JOIN permission_groups ON permission_groups.id = user_permission_groups.permission_group_id
JOIN permission_associations ON permission_associations.permission_group_id = permission_groups.id
JOIN permissions ON permission_associations.permission_id = permissions.id
GROUP BY users.id, permissions.name;
