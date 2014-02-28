# Noted.
#   file: application.coffee

#= require jquery
#= require_tree ./lib/vendor
#= require_self

$("div[data-field-span]").on "click", ->
  $(@).find("input").focus()

$("[rel=tipsy]").tipsy
  gravity: 's'
