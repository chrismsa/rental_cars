require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Volkswagen')
  end

  scenario 'and view details' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).not_to have_content('Volkswagen')
  end

  scenario 'and no manufacturers are created' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Nenhum fabricante cadastrado')
  end

  scenario 'and return to home page' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq manufacturers_path
  end
end
