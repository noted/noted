# Noted.
#   file: application.coffee

#= require jquery
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
    "orderedlist"
  ],
  buttonLabels:
    unorderedlist: "<i class='ss-icon'>list</i>"
    anchor: "<i class='ss-icon'>link</i>"
    quote: "<i class='ss-icon'>quote</i>"
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

# Filtering

available_tags = []

$('article.note').each ->
  available_tags = available_tags.concat(JSON.parse($(@).attr('data-tags')))

  i = 0

  while i < available_tags.length
    j = i + 1

    while j < available_tags.length
      available_tags.splice j--, 1  if available_tags[i] is available_tags[j]
      ++j
    ++i

selected_tags = []
$('ul.filter li').on 'click', ->
  # if selected, remove from list
  if $(@).attr('data-selected')
    index = selected_tags.indexOf($(@).attr('data-value'))
    selected_tags.splice(index, 1)
    $(@).attr('data-selected', false)
  else
    selected_tags.push($(@).attr('data-value'))
    $(@).attr('data-selected', true)

  refresh_viewed()

refresh_viewed = ->
  $('article.note').each ->
    current_note = $(@)

    tags = JSON.parse($(@).attr('data-tags'))

    keep = false
    for i in tags
      if tags.indexOf(i) > 0
        keep = true

    if keep = false
      current_note.hide()
    else
      current_note.show()
