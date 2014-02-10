require 'spec_helper'

describe NotesController do
  it '/:user/:project/notes' do
    expect(
      get '/neiltyson/the-cosmos/notes'
    ).to route_to(
      controller: 'notes',
      action: 'index',
      user: 'neiltyson',
      project: 'the-cosmos'
    )
  end

  it '/:user/:project/notes/new' do
    expect(
      get '/neiltyson/the-cosmos/notes/new'
    ).to route_to(
      controller: 'notes',
      action: 'new',
      user: 'neiltyson',
      project: 'the-cosmos'
    )
  end

  it '/:user/:project/notes/:id' do
    expect(
      get '/neiltyson/the-cosmos/notes/foobar'
    ).to route_to(
      controller: 'notes',
      action: 'show',
      user: 'neiltyson',
      project: 'the-cosmos',
      note: 'foobar'
    )
  end
end
