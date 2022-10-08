# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
other_user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
another_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: 'password')

warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão próximo ao Aeroporto Internacional SP Guarulhos')
other_warehouse = Warehouse.create!(name: 'Aeroporto RIO', code: 'RIO', city: 'Rio de Janeiro', area: 80_000, address: 'Avenida Rio Branco, 330', cep: '25000-000', description: 'Galpão destinado para cargas internacionais')
another_warehouse = Warehouse.create!(name: 'Aeroporto BH', code: 'BHZ', city: 'Belo Horizonte', area: 120_000, address: 'Avenida Tiradentes, 2100', cep: '35000-000', description: 'Galpão amplo para cargas internacionais')

supplier = Supplier.create!(corporate_name: 'OLLY LTDA', brand_name: 'OLLY', registration_number: '1133044000013', full_address: 'Rua das Cotovias, 111', city: 'Vinhedo', state: 'SP', email: 'contato@olly.com.br', phone_number: '(12) 4337-2230')
other_supplier = Supplier.create!(corporate_name: 'DANSON LTDA', brand_name: 'DANSON', registration_number: '1133048000015', full_address: 'Rua Mares do Sul, 330', city: 'Campinas', state: 'SP', email: 'contato@danson.com.br', phone_number: '(12) 4333-3000')
another_supplier = Supplier.create!(corporate_name: 'MARTEL LTDA', brand_name: 'MARTEL', registration_number: '1519044576013', full_address: 'Rua Goytacazes, 880', city: 'Paulínia', state: 'SP', email: 'contato@martel.com.br', phone_number: '(12) 4880-8000')

order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
other_order = Order.create!(user: other_user, warehouse: other_warehouse, supplier: other_supplier, estimated_delivery_date: 2.week.from_now)
another_order = Order.create!(user: another_user, warehouse: another_warehouse, supplier: another_supplier, estimated_delivery_date: 3.week.from_now)

product = ProductModel.create!(name: 'Vaso Borda Color', weight: 1500, width: 40, height: 100, depth: 40, supplier: supplier, sku: 'VASBC-12456-112201-A')
product_other = ProductModel.create!(name: 'Vaso Cimento', weight: 1800, width: 50, height: 70, depth: 50, supplier: supplier, sku: 'VASCI-54873-112201-A')

other_product = ProductModel.create!(name: 'Terra Adubada', weight: 1000, width: 25, height: 45, depth: 10, supplier: other_supplier, sku: 'TERAD-32195-113411-B')
another_product = ProductModel.create!(name: 'Composteira Média', weight: 3000, width: 60, height: 85, depth: 40, supplier: sanother_upplier, sku: 'COMPM-44512-112272-C')