//= require lib/vendor/jquery
//= require lib/vendor/underscore
//= require lib/vendor/jquery.ui
//= require lib/vendor/jquery.fittext
//= require lib/vendor/jquery.autogrow
//= require lib/vendor/jquery.tags
//= require lib/vendor/jquery.chosen
//= require lib/vendor/jquery.tipsy
//= require lib/vendor/jquery.autocomplete
//= require lib/vendor/ligature
//= require lib/vendor/ss-standard
//= require lib/vendor/ss-social
//= require lib/vendor/redactor
//= require lib/noted.contributors
//= require lib/noted.tags
//= require lib/analytics
//= require lib/ajax

$(document).ready ->
  console.log "Hi there. Looks like you're poking around Noted. If you're interested, check out the project on GitHub. https://github.com/noted/noted"

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

  $(".tabs.note ul li.view a").on "click", ->
    $("#view .text").html $(".redactor").getCode()

  $(".suggest").autocomplete
    serviceUrl: "/api/users/search.json"
    minChars: 3
