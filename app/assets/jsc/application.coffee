# Noted.
#   file: application.coffee

#= require jquery
#= require_tree ./lib
#= require_self

$("div[data-field-span]").on "click", ->
  $(@).find("input[type=text]").focus()

$("[rel=tipsy]").tipsy
  gravity: 's'

$(".redactor").redactor
  autoresize: false
