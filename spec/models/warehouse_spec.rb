require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      #Arrange
      warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
      #expect(warehouse).not_to be_valid => substitui as linhas de act e assert
    end
    it 'false when code is empty' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when address is empty' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when cep is empty' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '', city: 'Rio', area: 1000, description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when city is empty' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: '', area: 1000, description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when area is empty' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: '', description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when description is empty' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: '')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when code is already in use' do
      #Arrange
      first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida', cep: '35000-000', city: 'Niteroi', area: 3000, description: 'Outra descrição')
      #Act
      result = second_warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when name is already in use' do
      #Arrange
      first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      second_warehouse = Warehouse.new(name: 'Rio', code: 'RJO', address: 'Avenida', cep: '35000-000', city: 'Niteroi', area: 3000, description: 'Outra descrição')
      #Act
      result = second_warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when cep format is incorrect' do
      #Arrange
      warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '2500-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when code format is incorrect' do
      #Arrange
      warehouse = Warehouse.create(name: 'Rio', code: 'RIOJ', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
  end
end
