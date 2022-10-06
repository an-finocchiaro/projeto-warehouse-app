require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
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
    patch(order_path(order.id), params: { order: { supplier_id: 3}})
    #Assert
    expect(response).to redirect_to(root_path)
  end
end