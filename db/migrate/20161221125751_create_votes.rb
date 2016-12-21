class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.references :comment, index: true

      t.timestamps
    end
  end
end
