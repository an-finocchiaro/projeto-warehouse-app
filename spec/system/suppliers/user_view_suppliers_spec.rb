require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    #Act
    login_as(user)
    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    #Assert
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    first_supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br')
    second_supplier = Supplier.create!(corporate_name: 'BARUH LTDA', brand_name: 'BARUH', registration_number: '4437033000015', full_address: 'Avenida Ondina, 444', city: 'Maricá', state: 'RJ', email: 'contato@baruh.com.br')
    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content 'OLLY'
    expect(page).to have_content 'Vinhedo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'BARUH'
    expect(page).to have_content 'Maricá'
    expect(page).to have_content 'RJ'
  end

  it 'e não tem fornecedores cadastrados' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content 'Não existem fornecedores cadastrados'
    expect(page).not_to have_content 'OLLY'
    expect(page).not_to have_content 'Vinhedo'
    expect(page).not_to have_content 'BARUH'
    expect(page).not_to have_content 'Maricá'

  end
end