require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'ABCDE-12456-112211-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'ABCDE-12456-112211-B')
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade',	with: '8'
    click_on 'Gravar' 
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê produtos de outro fornecedor' do
    #Arrange
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: '11223344')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    supplier_a = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
    registration_number: '4344721600010', email: 'contato@acme.com', full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', phone_number: '(15) 4330-1000')
    supplier_b = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, estimated_delivery_date: 2.days.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier_a, sku: 'ABCDE-12456-112211-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier_b, sku: 'ABCDE-12456-112211-B')
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    #Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end

end