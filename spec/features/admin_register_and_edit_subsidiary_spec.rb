require 'rails_helper'
require 'cpf_cnpj'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Cadastrar filial', href: new_subsidiary_path)
  end

  scenario 'successfuly' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar filial'

    fill_in 'Nome', with: 'Nome da filial'
    fill_in 'CNPJ', with: '07.069.345/0862-74'
    fill_in 'Endereço', with: 'Endereço da filial'
    click_on 'Enviar'

    expect(page).to have_content('Nome da filial')
    expect(page).to have_content('07.069.345/0862-74')
    expect(page).to have_content('Endereço da filial')
  end

  scenario 'and check all create fields are fill' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar filial'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da filial')
  end

  scenario 'and check return link in page_new' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar filial'

    expect(page).to have_link('Voltar', href: subsidiaries_path)
  end

  scenario 'from show page' do
    Subsidiary.create!(name: 'Nome da filial 1', cnpj: '07.069.345/0862-74', 
                      address: 'Endereço da filial 1')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial 1'

    expect(page).to have_link('Editar')
  end

  scenario 'and update subsidiary' do
    Subsidiary.create!(name: 'Nome da filial 1', cnpj: '07.069.345/0862-74', 
                      address: 'Endereço da filial 1')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial 1'
    click_on 'Editar'

    fill_in 'Nome', with: 'Nome da filial 2'
    fill_in 'CNPJ', with: '40.702.532/0822-21'
    fill_in 'Endereço', with: 'Endereço da filial 2'
    click_on 'Enviar'

    expect(page).to have_content('Nome da filial 2')
    expect(page).to have_content('40.702.532/0822-21')
    expect(page).to have_content('Endereço da filial 2')
  end

  scenario 'and check all update fields are fill' do
    Subsidiary.create(name: 'Nome da filial 1', cnpj: '07.069.345/0862-74', 
                      address: 'Endereço da filial 1')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial 1'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da filial')
  end

  scenario 'and check return link in page_edit' do
    Subsidiary.create(name: 'Nome da filial 1', cnpj: '07.069.345/0862-74', 
                      address: 'Endereço da filial 1')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial 1'
    click_on 'Editar'

    expect(page).to have_link('Voltar', href: subsidiaries_path)
  end
end