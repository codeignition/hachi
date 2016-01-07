class AddRegisteredToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean 'registered', default: false
    end
  end
end
