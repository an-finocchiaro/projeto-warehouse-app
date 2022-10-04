require 'rails_helper'

describe 'Usuário edita detalhes de um Modelo de Produto' do

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
    click_on 'Editar'
    fill_in 'Nome', with: 'TV 32 polegadas'
    fill_in 'SKU', with: 'TV32-SAMS-VTD-547001'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'TV 32 polegadas'
    expect(page).to have_content 'TV32-SAMS-VTD-547001'
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm'
    
  end
end