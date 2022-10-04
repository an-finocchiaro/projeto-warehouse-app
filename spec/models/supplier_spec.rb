require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    it 'false when corporate_name is empty' do
      supplier = Supplier.new(corporate_name: '', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
      result = supplier.valid?
      expect(result).to eq false
    end
    it 'false when brand_name is empty' do
      supplier = Supplier.new(corporate_name: 'OLLY LTDA', brand_name: '', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
      result = supplier.valid?
      expect(result).to eq false
    end
    it 'false when registration_number is empty' do
      supplier = Supplier.new(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
      result = supplier.valid?
      expect(result).to eq false
    end
    it 'false when email is empty' do
      supplier = Supplier.new(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: '')
      result = supplier.valid?
      expect(result).to eq false
    end
    it 'false when registration_number is incorrect' do
      supplier = Supplier.new(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '11330440000133', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
      result = supplier.valid?
      expect(result).to eq false
    end
    it 'false when registration_number is already in use' do
      first_supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
      second_supplier = Supplier.new(corporate_name: 'BARUH LTDA', brand_name: 'BARUH', registration_number: '1133044000013', full_address: 'Avenida Ondina, 444', city: 'Maricá', state: 'RJ', email: 'contato@baruh.com.br')
      result = second_supplier.valid?
      expect(result).to eq false
    end
    it 'false when email is incorrect' do
      supplier = Supplier.new(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@baruh@com.br')
      result = supplier.valid?
      expect(result).to eq false
    end
  end

  describe '#full_description' do
    it 'exibe a razão social e o nome fantasia' do
      #Arrange
      s = Supplier.new(brand_name: 'BULL', corporate_name: 'BULL LTDA')
      #Act
      result = s.full_description()
      #Assert
      expect(result).to eq('BULL - BULL LTDA')
    end
  end
end


