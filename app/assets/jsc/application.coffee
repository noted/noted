# Noted.
#   file: application.coffee

#= require jquery
#= require jquery_ujs
#= require peek
#= require peek/views/dalli
#= require peek/views/performance_bar
#= require peek/views/rblineprof
#= require_tree ./lib
#= require_self

$("div[data-field-span]").on "click", ->
  $(@).find("input[type=text]").focus()

$("[rel=tipsy]").tipsy
  gravity: "s"

editor = new MediumEditor(".editable",
  buttons: [
    "bold",
    "italic",
    "underline",
    "anchor",
    "header1",
    "header2",
    "quote",
    "unorderedlist",
    "orderedlist",
    "outdent",
    "indent"
  ],
  buttonLabels:
    unorderedlist: "<i class='ss-icon'>list</i>"
    anchor: "<i class='ss-icon'>link</i>"
    quote: "<i class='ss-icon'>quote</i>"
  placeholder: "Your body text..."
)

$(".editable").on "input", ->
  $(".text").html($(".editable").html())

$(".selectize").selectize
  delimiter: ','
  persist: false
  openOnFocus: false
  create: (input) ->
    value: input
    text: input
