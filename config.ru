#!/usr/bin/env rackup
# encoding: utf-8

require File.expand_path("../config/boot.rb", __FILE__)

map '/a' do
  run Padrino::Assets.environment
end

run Padrino.application
