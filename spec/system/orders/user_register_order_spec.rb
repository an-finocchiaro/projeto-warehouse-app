require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Registrar Pedido'
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  
  it 'com sucesso' do
    #Arrange
    User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')
    user = User.create!(name: 'Sergio', email: 'sergio@email.com',
                       password: '12345678')
    
    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro',
                    area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000',
                    description: 'Galpão do Rio')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                 area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    
    Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY',
                    registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
               registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select 'ACME - ACME LTDA', from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'
    #Assert
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME - ACME LTDA'
    expect(page).to have_content 'Usuário Responsável: Sergio - sergio@email.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Galpão Rio'
    expect(page).not_to have_content 'OLLY LTDA'
  end

  it 'e não informa a data de entrega' do
    #Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com',
                       password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
               registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Gravar'
    #Assert
    expect(page).to have_content 'Não foi possível registrar o pedido'
    expect(page).to have_content 'Data Prevista de Entrega não pode ficar em branco'
  end
end