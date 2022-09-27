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
end