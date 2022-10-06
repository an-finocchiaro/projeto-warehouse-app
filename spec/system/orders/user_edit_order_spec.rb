require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')
    
    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
    #Act
    visit edit_order_path(order.id)
    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    #Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')
    
    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')
    other_supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')

    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
    #Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in "Data Prevista de Entrega",	with: "12/12/2022"
    select 'OLLY LTDA', from: 'Fornecedor'
    click_on 'Gravar'
    #Assert
    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Fornecedor: OLLY - OLLY LTDA'
    expect(page).to have_content "Data Prevista de Entrega: 12/12/2022"
  end

  it 'caso seja o responsável' do
    #Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')
    sergio = User.create!(name: 'Sergio', email: 'sergio@email.com',
                       password: '12345678')
    
    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
    #Act
    login_as(sergio)
    visit edit_order_path(order.id)
    #Assert
    expect(current_path).to eq root_path
  end

end