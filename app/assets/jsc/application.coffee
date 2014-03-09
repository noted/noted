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

editor = new MediumEditor(".editable",
  buttons: [
    'bold',
    'italic',
    'underline',
    'anchor',
    'header1',
    'header2',
    'quote',
    'unorderedlist',
    'orderedlist'
  ],
  buttonLabels:
    unorderedlist: '<i class="ss-icon">list</i>'
    anchor: '<i class="ss-icon">link</i>'
    quote: '<i class="ss-icon">quote</i>'
)

$(".editable").on "input", ->
  $('.text').html($('.editable').html())
