json.extract! block, :id, :hash_block, :prev_block, :block_index, :time, :bits, :created_at, :updated_at
json.url block_url(block, format: :json)
