class AddUidNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid_number, :integer
  end
end
