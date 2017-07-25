class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :username      , :null => false
      t.string :name          , :null => false
      t.string :logo          , :null => false
      t.string :main_contact  , :null => false
      t.string :address       , :null => false
      t.string :phone         , :null => false
      t.string :status        , :null => false
      t.string :email         , :null => false

      t.timestamps
    end

    add_index :clients, :email, unique: true
    add_index :clients, :username, unique: true
  end
end
