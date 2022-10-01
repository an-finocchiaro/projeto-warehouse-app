require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    #Arrange criar um galpão
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    w = Warehouse.create!(name: 'Cuiabá', code: 'CWB', area: 10000, cep: '56000-000', city: 'Cuiabá', description: 'Galpão no centro do país', address: 'Avenida dos Jacarés, 1000')

    #Act visitar tela inicial, abrir o galpão, clicar em remover
    login_as(user)
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    #Assert espero que o galpão não apareça
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga outros galpões' do
    #Arrange
    user = User.create!(name: 'Andréa', email: 'andrea@email.com', password: 'password')
    first_warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', area: 10000, cep: '56000-000', city: 'Cuiabá', description: 'Galpão no centro do país', address: 'Avenida dos Jacarés, 1000')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20000, cep: '46000-000', city: 'Belo Horizonte', description: 'Galpão para cargas mineiras', address: 'Avenida Tiradentes, 20')
    #Act
    login_as(user)
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'
    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).to have_content 'Belo Horizonte'
  end

end