require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    #Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODA-12456-112201-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 20, width: 15, height: 25, depth: 35, supplier: supplier, sku: 'PRODB-34555-113411-B')
    product_c = ProductModel.create!(name: 'Produto C', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODC-12333-112272-C')

    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a) } 
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b) } 
    #Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    #Assert
    within("section#stock_products") do
      expect(page).to have_content 'Itens em Estoque'
      expect(page).to have_content '3 x PRODA-12456-112201-A'
      expect(page).to have_content '2 x PRODB-34555-113411-B'
      expect(page).not_to have_content 'PRODC-12333-112272-C'
    end
  end

  it 'e dá baixa em um item' do
    #Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODA-12456-112201-A')
    
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a) }
    #Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'PRODA-12456-112201-A', from: 'Itens para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - SP'
    click_on 'Confirmar Retirada'
    #Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x PRODA-12456-112201-A'
  end

  it 'e não vê itens com estoque igual a zero' do
    #Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODA-12456-112201-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 20, width: 15, height: 25, depth: 35, supplier: supplier, sku: 'PRODB-34555-113411-B')

    stock_product_a =  StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)
    stock_product_b =  StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b)

    stock_product_a.create_stock_product_destination!(recipient: 'João', address: 'Rua do João')

    #Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'

    #Assert
    within("section#stock_products") do
      expect(page).to have_content '1 x PRODB-34555-113411-B'
      expect(page).not_to have_content 'PRODA-12456-112201-A'
    end
  end
end


      