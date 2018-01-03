class CreateUserPermissionGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_permission_groups do |t|
      t.references :user, foreign_key: true, null: false
      t.references :permission_group, foreign_key: true, null: false
    end
  end
end
