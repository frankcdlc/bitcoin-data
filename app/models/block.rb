class Block < ApplicationRecord
  validates :hash_block, presence: true
  validates :hash_block, uniqueness: true
  validates :hash_block, format: { with: /\A[0-9a-zA-Z]+\z/,
                                   message: "only allows letters and numbers" }
end
