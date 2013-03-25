$(document).ready ->
  $("#user aside h2").fitText 1.1

  $(".description h4 a.expand").on "click", ->
    if $(".description .text").hasClass("hidden")
      $(".description .text").removeClass("hidden").addClass("display")
    else
      $(".description .text").removeClass("display").addClass "hidden"
