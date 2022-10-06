require 'rails_helper'

RSpec.describe Order, type: :model do

  describe '#valid?' do
    it 'deve ter um código' do
      #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com',
                       password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    
      supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY',
                    registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-01')
      #Act
      result = order.valid?
      #Assert
      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      #Arrange
      order = Order.new(estimated_delivery_date: '')
      #Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      #Assert
      expect(result).to be true
    end

    it 'data estimada de entrega não deve ser passada' do
      #Arrange
      order = Order.new(estimated_delivery_date: 2.days.ago)
      #Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      #Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
    end

    it 'data estimada de entrega não deve ser igual a hoje' do
      #Arrange
      order = Order.new(estimated_delivery_date: Date.today)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
    end
    it 'data estimada de entrega deve ser igual ou maior do que amanhã' do
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end

  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com',
                       password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    
      supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY',
                    registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-01')
      #Act
      order.save!
      result = order.code
      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end
    it 'e o código é único' do
      #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com',
                       password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    
      supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY',
                    registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-01')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-15')
      #Act
      second_order.save!
      #Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
