require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página índice de fornecedores' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on "OLLY"
    click_on 'Editar'
    #Assert
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field('Razão Social', with: 'OLLY LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'OLLY')
    expect(page).to have_field('CNPJ', with: '1133044000013')
    expect(page).to have_field('Endereço', with: 'Rua das Cotovias, 111')
    expect(page).to have_field('Cidade', with: 'Vinhedo')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('E-mail', with: 'contato@olly.com.br')
    expect(page).to have_field('Telefone', with: '(12) 4337-2230')
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on "OLLY"
    click_on 'Editar'
    fill_in 'Endereço', with: 'Estrada da Boiada,3280'
    fill_in 'E-mail', with: 'faleconosco@olly.com.br'
    fill_in 'Telefone', with: '(12) 3230-3000'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Estrada da Boiada,3280'
    expect(page).to have_content 'faleconosco@olly.com.br'
    expect(page).to have_content '(12) 3230-3000'
  end

  it 'com dados incorretos' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on "OLLY"
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Não foi possível atualizar o fornecedor'
  end
end