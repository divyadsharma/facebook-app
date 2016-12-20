class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.references :comment, index: true

      t.timestamps
    end
  end
end
