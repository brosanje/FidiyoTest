class AddLowerIndexesToClients < ActiveRecord::Migration[5.1]
  def change
    add_index :clients, "lower(name) varchar_pattern_ops"
    add_index :clients, "lower(main_contact) varchar_pattern_ops"
    add_index :clients, "lower(email)"
  end
end
