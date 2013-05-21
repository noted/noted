module Noted
  class API < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers

    enable :sessions
  end
end
