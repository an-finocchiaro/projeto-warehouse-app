class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :cep, format: {with: /\d{5}\-\d{3}/}
  validates :code, length: {is:3}

  def full_description
    "#{code} - #{name}"
  end
end
