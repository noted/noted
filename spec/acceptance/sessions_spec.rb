require 'spec_helper'

feature 'Sessions' do
  let(:user) { create(:user) }

  scenario 'login' do
    visit '/login'

    within('#main') do
      find(:css, 'input[type=email]').set(user.email)
      find(:css, 'input[type=password]').set('foobar')
    end
    find(:css, 'input[type=submit]').click

    page.should have_content 'Neil deGrasse Tyson'
  end

  scenario 'logout' do
    visit '/login'

    within('#main') do
      find(:css, 'input[type=email]').set(user.email)
      find(:css, 'input[type=password]').set('foobar')
    end
    find(:css, 'input[type=submit]').click

    click_link 'Logout'

    page.should have_content 'Research together'
  end
end
