class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :voteable, polymorphic: true, index: true
      t.integer :user_id
      t.boolean :vote

      t.timestamps
    end
  end
end
