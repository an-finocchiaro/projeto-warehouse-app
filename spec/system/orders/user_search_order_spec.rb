require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    #Act
    login_as(user)
    visit root_path
    #Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    #Assert
    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e encontra' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    #Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 Pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME - ACME LTDA'
  end

  it 'e encontra múltiplos pedidos' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98765')
    second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00000')
    third_order = order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'
    #Assert
    expect(page).to have_content ('2 Pedidos encontrados')
    expect(page).to have_content('GRU12345')
    expect(page).to have_content('GRU98765')
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).not_to have_content('SDU00000')
    expect(page).not_to have_content "Galpão Destino: SDU - Aeroporto Rio"
  end
end