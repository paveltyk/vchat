class CreateChatters < ActiveRecord::Migration
  def self.up
    create_table :chatters do |t|
      t.string :identity, :null => false

      t.timestamps
    end
    add_index :chatters, :identity
  end

  def self.down
    drop_table :chatters
  end
end
