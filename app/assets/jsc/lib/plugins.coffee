$(document).ready ->
  ligature(false, $(".text"));

  $("#user aside h2").fitText 1.1

  $("select.chosen").chosen()

  $(".description h4 a.expand").on "click", ->
    if $(".description .text").hasClass("hidden")
      $(".description .text").removeClass("hidden").addClass("display")
    else
      $(".description .text").removeClass("display").addClass "hidden"

  $(".tabs").tabs()

  $(".tooltip").tipsy gravity: $.fn.tipsy.autoNS

  $(".redactor").redactor
    autoresize: false
    minHeight: 200
    source: true

  $(".suggest").autocomplete
    serviceUrl: "/api/users/search.json"
    minChars: 3
