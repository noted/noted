require 'spec_helper'

describe UsersController do
  it '/:user' do
    expect(
      get '/foobar'
    ).to route_to(
      controller: 'users',
      action: 'show',
      user: 'foobar'
    )
  end
end
