class Product < ApplicationRecord
  belongs_to :store

  has_many :ware_houses
  has_maany :stores, through: :ware_houses
end
