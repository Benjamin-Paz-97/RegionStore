
class Region < ApplicationRecord
  has_many :productos, dependent: :restrict_with_exception

  # Validaciones básicas para integridad de datos
  validates :name, presence: true, uniqueness: true
end
