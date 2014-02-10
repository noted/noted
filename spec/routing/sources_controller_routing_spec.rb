require 'spec_helper'

describe SourcesController do
  it '/:user/:project/sources' do
    expect(
      get '/neiltyson/the-cosmos/sources'
    ).to route_to(
      controller: 'sources',
      action: 'index',
      user: 'neiltyson',
      project: 'the-cosmos'
    )
  end

  it '/:user/:project/sources/new' do
    expect(
      get '/neiltyson/the-cosmos/sources/new'
    ).to route_to(
      controller: 'sources',
      action: 'new',
      user: 'neiltyson',
      project: 'the-cosmos'
    )
  end

  it '/:user/:project/sources/:id' do
    expect(
      get '/neiltyson/the-cosmos/sources/foobar'
    ).to route_to(
      controller: 'sources',
      action: 'show',
      user: 'neiltyson',
      project: 'the-cosmos',
      source: 'foobar'
    )
  end
end
