require 'rails_helper'

feature 'Admin register rental' do
  
  scenario 'successfully' do
    customer = Customer.create!(name: 'Fulano da silva', cpf: '194.713.755-76', email: 'teste@test.com.br')
    car_category = CarCategory.create(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                                      third_party_insurance: '1800')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    click_on 'Cadastrar locação'

    fill_in "Data de início",	with: "04/05/2024"
    fill_in "Data de término",	with: "08/05/2024"
    select customer.name, from: 'Cliente'
    select car_category.name, from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Data de início: 04/05/2024')
    expect(page).to have_content('Data de término: 08/05/2024')
    expect(page).to have_content("Cliente: #{customer.name}")
    expect(page).to have_content("Categoria: #{car_category.name}")
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit new_rental_path
    click_on 'Enviar'

    expect(page).to have_content('Data de início não pode ficar em branco')
    expect(page).to have_content('Data de término não pode ficar em branco')
    expect(page).to have_content('Cliente é obrigatório(a)')
    expect(page).to have_content('Categoria é obrigatório(a)')
  end
end