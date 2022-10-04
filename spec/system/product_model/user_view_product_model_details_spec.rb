require 'rails_helper'

describe 'Usuário vê detalhes de um Modelo de Produto' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
    ProductModel.create!(name: 'TV 32', weight: 8000, width:70, height:45, depth:10, sku:'TV32-SAMS-VTD-547236', supplier: supplier)
    ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'
    #Assert
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm'
    expect(page).to have_content 'TV32-SAMS-VTD-547236'
    expect(page).to have_content 'Peso: 8000g'
  end

  it 'e retorna ao índice de Modelos de Produtos' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
    ProductModel.create!(name: 'TV 32', weight: 8000, width:70, height:45, depth:10, sku:'TV32-SAMS-VTD-547236', supplier: supplier)
    ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'
    click_on 'Voltar'
    #Assert
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content 'TV32-SAMS-VTD-547236'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ7743'
    expect(current_path).to eq(product_models_path) 
  end
end

