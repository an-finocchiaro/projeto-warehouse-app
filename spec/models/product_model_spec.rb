require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: '', weight: 3000, width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when weight is empty' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight:'', width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when width is empty' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:'', height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when height is empty' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:'', depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when depth is empty' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:'', sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when sku is empty' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:20, sku:'', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when sku is not 20 characters long' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ774', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when sku is already in use' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      other_product_model = ProductModel.new(name: 'TV 40 Polegadas', weight: 5000, width:90, height:75, depth:10, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(other_product_model).not_to be_valid
    end
    it 'false when weight is equal to or less than 0' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: -10, width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when width is equal to or less than 0' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:0, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when height is equal to or less than 0' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:-15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    it 'false when depth is equal to or less than 0' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
      product_model = ProductModel.new(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:0, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
      #Act
      #Assert
      expect(product_model).not_to be_valid
    end
    
  end
end
