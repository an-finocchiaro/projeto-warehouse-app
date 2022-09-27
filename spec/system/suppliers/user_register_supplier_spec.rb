require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir do índice de fornecedores' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    #Assert
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Telefone')
  end

  it 'com sucesso' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: 'OLLY LTDA'
    fill_in 'Nome Fantasia', with: 'OLLY'
    fill_in 'CNPJ', with: '1133044000013'
    fill_in 'Endereço', with: 'Rua das Cotovias, 111'
    fill_in 'Cidade', with: 'Vinhedo'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@olly.com.br'
    fill_in 'Telefone', with: '(12) 4337-2230'
    click_on 'Enviar'
    #Assert
    expect(current_path).to eql(suppliers_path)
    expect(page).to have_content 'OLLY'
    expect(page).to have_content 'Vinhedo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
  end

  it 'com dados incompletos' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: 'Rua das Cotovias, 111'
    fill_in 'Cidade', with: 'Vinhedo'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: ''
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
  end
end