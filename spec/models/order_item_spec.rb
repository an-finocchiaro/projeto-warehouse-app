require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe '#valid?' do
    it 'a quantidade não pode estar em branco' do
      #Arrange
      user = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')

      warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
      registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

      product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'ABCDE-12456-112211-A')

      order_item = OrderItem.new(order: order, product_model: product_a, quantity: '')

      #Act
      result = order_item.valid?
      #Assert
      expect(result).to be false
    end

    it 'a quantidade tem que ser maior do que zero' do
      #Arrange
      user = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')

      warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
      registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

      product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'ABCDE-12456-112211-A')

      order_item = OrderItem.new(order: order, product_model: product_a, quantity: '0')

      #Act
      result = order_item.valid?
      #Assert
      expect(result).to be false
    end
  end
end
