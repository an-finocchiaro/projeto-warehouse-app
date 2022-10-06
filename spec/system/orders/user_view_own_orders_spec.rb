require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Meus Pedidos'
    #Assert
    expect(current_path).to eq new_user_session_path
   
  end

  it 'e não vê outros pedidos' do
     #Arrange
     ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')
     sergio = User.create!(name: 'Sergio', email: 'sergio@email.com',
                        password: '12345678')
     
     warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
     supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
     registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')
 
     first_order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
 
     second_order = Order.create!(user: sergio, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
 
     third_order = order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
     #Act
     login_as(ana)
     visit root_path
     click_on 'Meus Pedidos'
     #Assert
     expect(page).to have_content first_order.code
     expect(page).not_to have_content second_order.code
     expect(page).to have_content third_order.code
  end

  it 'e visita um pedido' do
    #Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    first_order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
    #Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code
    #Assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Galpão Destino: SDU - Galpão Rio'
    expect(page).to have_content 'Fornecedor: ACME - ACME LTDA'
    formatted_date = I18n.localize(2.days.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it 'e não visita pedidos de outros usuários' do
    #Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')
    sergio = User.create!(name: 'Sergio', email: 'sergio@email.com',
                        password: '12345678')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    first_order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
    #Act
    login_as(sergio)
    visit order_path(first_order.id)
    #Assert
    expect(current_path).not_to eq order_path(first_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem acesso a esse pedido'
  end
end