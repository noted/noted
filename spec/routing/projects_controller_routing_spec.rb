require 'spec_helper'

describe ProjectsController do
  it '/new' do
    expect(
      get '/new'
    ).to route_to(
      controller: 'projects',
      action: 'new'
    )
  end

  it '/:user/:project' do
    expect(
      get: '/neiltyson/the-cosmos'
    ).to route_to(
      controller: 'projects',
      action: 'show',
      user: 'neiltyson',
      project: 'the-cosmos'
    )
  end
end
