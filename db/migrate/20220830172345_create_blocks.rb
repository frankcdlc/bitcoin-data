class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.string :hash_block
      t.string :prev_block
      t.integer :block_index
      t.integer :time
      t.integer :bits

      t.timestamps
    end
    add_index :blocks, :hash_block, unique: true
    add_index :blocks, :prev_block, unique: true
    add_index :blocks, :block_index, unique: true
  end
end
