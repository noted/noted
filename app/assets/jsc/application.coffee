$(document).ready ->
  $("#user aside h2").fitText 1.1

  $(".description h4 a.expand").on "click", ->
    if $(".description .text").hasClass("hidden")
      $(".description .text").removeClass("hidden").addClass("display")
    else
      $(".description .text").removeClass("display").addClass "hidden"

  $('input.tags').tagsManager
    hiddenTagListName: 'note[tags]'

  $("input.tags").autoGrowInput
    comfortZone: 20
    minWidth: 200
    maxWidth: 900


  $(".textbox footer").click ->
    $(".textbox footer input").focus()
