require 'spec_helper'

feature 'Users' do
  scenario 'join (with valid info)' do
    visit '/join'

    within('#user section') do
      find(:css, "input[name='user[name]']").set('Les Grossman')
      find(:css, "input[name='user[username]']").set('les')
      find(:css, "input[name='user[email]']").set('les@fanzter.com')
      find(:css, "input[name='password[password]']").set('foobar')
      find(:css, "input[name='password[confirm]']").set('foobar')
    end
    find(:css, "button[type='submit']").click

    page.should have_content 'Les Grossman'
  end

  scenario 'join (without valid info)' do
    visit '/join'

    within('#user section') do
      find(:css, "input[name='user[name]']").set('Les Grossman')
      find(:css, "input[name='user[username]']").set('l')
      find(:css, "input[name='user[email]']").set('lesfanzter.com')
      find(:css, "input[name='password[password]']").set('foobar')
      find(:css, "input[name='password[confirm]']").set('bar')
    end
    find(:css, "button[type='submit']").click

    page.should_not have_content 'Les Grossman'
  end
end
