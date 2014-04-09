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

root = exports ? this

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

$("a.flash-hide").on "click", ->
  $(".flash").hide()

$(".editable").on "input", ->
  $(".text").html($(".editable").html())

if $(".editable").html() == "<p><br></p>"
  $(".editable").html("")

tags = $(".selectize").selectize
  delimiter: ','
  persist: false
  openOnFocus: false
  create: (input) ->
    value: input
    text: input
  onChange: (val) ->
    root.save()

$(document).ready ->
  move_nav()

window.onresize = ->
  move_nav()

move_nav = ->
  if $(".editable").length > 0
    right = $(window).width() - ($(".editable").offset().left + $(".editable").width())

    $("nav.note-secondary-actions").css('right', right)
