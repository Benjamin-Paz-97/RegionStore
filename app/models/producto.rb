
class Producto < ApplicationRecord
  # Asociaciones
  belongs_to :region
  has_one_attached :photo

  # Validaciones para asegurar integridad en la base de datos
  validates :titulo, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
