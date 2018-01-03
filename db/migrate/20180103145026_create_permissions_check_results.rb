class CreatePermissionsCheckResults < ActiveRecord::Migration[5.1]
  def change
    create_view :permissions_check_results, materialized: true
  end
end
