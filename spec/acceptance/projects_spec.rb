require 'spec_helper'

feature 'Projects' do
  let(:user) { create(:user) }

  before do
    visit '/login'

    within('#main') do
      find(:css, 'input[type=email]').set(user.email)
      find(:css, 'input[type=password]').set('foobar')
    end
    find(:css, 'input[type=submit]').click
  end

  scenario 'create' do
    visit '/new'

    within('#project') do
      find(:css, "input[name='project[title]']").set('The Cosmos')
      find(:css, 'textarea').set('<p>Foobar.</p>')
    end
    find(:css, 'button').click

    page.should have_content 'The Cosmos'
    page.should have_content 'Foobar.'
  end
end
