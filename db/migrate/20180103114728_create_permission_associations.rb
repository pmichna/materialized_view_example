class CreatePermissionAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :permission_associations do |t|
      t.references :permission, foreign_key: true, null: false
      t.references :permission_group, foreign_key: true, null: false
    end
  end
end
