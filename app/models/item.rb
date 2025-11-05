class Item < ApplicationRecord
  belongs_to :list

  after_create_commit -> { broadcast_prepend_to list, target: "items" }
  after_update_commit -> { broadcast_replace_to list }
  after_destroy_commit -> { broadcast_remove_to list }
end
