require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    #Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :pending)
    #Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
  end

  it 'e pedido foi cancelado' do
    #Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :pending)
    #Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
  end
end