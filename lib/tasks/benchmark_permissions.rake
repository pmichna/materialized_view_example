# frozen_string_literal: true

require 'benchmark'

task benchmark_permissions: :environment do
  user = User.order('RANDOM()').first

  n = 1000
  PermissionsCheckResult.refresh

  Benchmark.bm do |x|
    x.report('joins - 1 permission') { n.times { ; joins_check(user, permissions(1)); } }
    x.report('joins - 2 permissions') { n.times { ; joins_check(user, permissions(2)); } }
    x.report('joins - 3 permissions') { n.times { ; joins_check(user, permissions(3)); } }
    x.report('joins - 4 permissions') { n.times { ; joins_check(user, permissions(4)); } }

    x.report('view - 1 permission') { n.times { ; view_check(user, permissions(1)); } }
    x.report('view - 2 permissions') { n.times { ; view_check(user, permissions(2)); } }
    x.report('view - 3 permissions') { n.times { ; view_check(user, permissions(3)); } }
    x.report('view - 4 permissions') { n.times { ; view_check(user, permissions(4)); } }
  end
end

def joins_check(user, permissions)
  Permission.distinct
            .joins(permission_groups: :users)
            .where(name: permissions, users: {id: user.id})
            .count == permissions.length
end

def view_check(user, permissions)
  PermissionsCheckResult.user_has_permissions?(user, *permissions)
end

def permissions(n)
  Permission.names.keys.sample(n)
end
