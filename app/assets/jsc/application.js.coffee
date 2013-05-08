//= require lib/vendor/jquery
//= require lib/vendor/underscore
//= require lib/vendor/jquery.ui
//= require lib/vendor/jquery.fittext
//= require lib/vendor/jquery.autoresize
//= require lib/vendor/jquery.autogrow
//= require lib/vendor/jquery.tags
//= require lib/vendor/jquery.chosen
//= require lib/vendor/jquery.tipsy
//= require lib/vendor/jquery.autocomplete
//= require lib/vendor/jquery.autosuggest
//= require lib/vendor/jquery-ui.autocomplete
//= require lib/vendor/ligature
//= require lib/vendor/ss-standard
//= require lib/vendor/ss-social
//= require lib/vendor/redactor
//= require lib/noted.contributors
//= require lib/noted.tags

$(document).ready ->
  ligature(false, $(".text"));

  $("#user aside h2").fitText 1.1

  $("select.chosen").chosen();

  $(".description h4 a.expand").on "click", ->
    if $(".description .text").hasClass("hidden")
      $(".description .text").removeClass("hidden").addClass("display")
    else
      $(".description .text").removeClass("display").addClass "hidden"

  $(".tabs").tabs()

  $(".tooltip").tipsy gravity: $.fn.tipsy.autoNS

  $(".redactor").redactor()

  #$("input.autosuggest").autocomplete({ serviceUrl: '/api/users/search' });
  #$("input.autosuggest").autoSuggest("/api/users/search2")

  split = (val) ->
    val.split /,\s*/
  extractLast = (term) ->
    split(term).pop()

  # don't navigate away from the field on tab when selecting an item
  $("input.autosuggest").bind("keydown", (event) ->
    event.preventDefault()  if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
  ).autocomplete
    source: (request, response) ->
      $.getJSON "/api/users/search3.json",
        term: extractLast(request.term)
      , response

    search: ->

      # custom minLength
      term = extractLast(@value)
      false  if term.length < 2

    focus: ->

      # prevent value inserted on focus
      #false

    select: (event, ui) ->
      terms = split(@value)

      # remove the current input
      terms.pop()

      # add the selected item
      terms.push ui.item.value

      # add placeholder to get the comma-and-space at the end
      terms.push ""
      @value = terms.join(", ")
      false
