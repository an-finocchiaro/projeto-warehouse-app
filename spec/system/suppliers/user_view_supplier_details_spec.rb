require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'OLLY'
    #Assert
    expect(page).to have_content 'OLLY LTDA'
    expect(page).to have_content '1133044000013'
    expect(page).to have_content 'Rua das Cotovias, 111'
    expect(page).to have_content 'Vinhedo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'contato@olly.com.br'
  end

  it 'e retorna ao índice de fornecedores' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'OLLY'
    click_on 'Voltar'
    #Assert
    expect(current_path).to eql(suppliers_path)
  end

  it 'e vê seus Modelos de Produtos' do
    #Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br', phone_number: '(11) 5501-3300')
    product_model = ProductModel.create!(name: 'TV 32', weight: 8000, width:70, height:45, depth:10, sku:'TV32-SAMS-VTD-547236', supplier: supplier)
    other_product_model = ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width:80, height:15, depth:20, sku:'SOU71-SAMSU-NOIZ7743', supplier: supplier)
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'
    #Assert
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content '8000'
    expect(page).to have_content '80'
    expect(page).to have_content '45'
    expect(page).to have_content '20'
    expect(page).to have_content 'TV32-SAMS-VTD-547236'
  end
end