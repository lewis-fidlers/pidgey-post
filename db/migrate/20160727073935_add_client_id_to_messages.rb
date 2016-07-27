class AddClientIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :client_id, :integer, index: :true
  end
end
