class Tenant < ApplicationRecord
  validates :age,
            exclusion: {
              in: (0..17).to_a,
              message: 'A tenant must be over 18 years of age',
            }
  has_many :leases
  has_many :apartments, through: :leases, dependent: :destroy
end
