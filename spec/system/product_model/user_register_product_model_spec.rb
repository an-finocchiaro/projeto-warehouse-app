require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
    other_supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil Ltda', registration_number: '3210987654321', full_address: 'Av. Ibirapuera, 300', city: 'Sao Paulo', state: 'SP', email: 'contato@lg.com.br')
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV40-SAMS-VTD-753876'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 40 polegadas'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV40-SAMS-VTD-753876'
    expect(page).to have_content 'Dimensão: 60cm x 90cm x 10cm'
    expect(page).to have_content 'Peso: 10000g'
  end

  it 'e deve preencher todos os campos do formulário' do
    #Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos Ltda', registration_number: '1234567890123', full_address: 'Av. Naçoes Unidas, 1000', city: 'Sao Paulo', state: 'SP', email: 'sac@samsung.com.br')
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: ''
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto'
  end
end