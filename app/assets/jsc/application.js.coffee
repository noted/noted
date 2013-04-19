//= require lib/vendor/jquery
//= require lib/vendor/underscore
//= require lib/vendor/jquery.ui
//= require lib/vendor/jquery.fittext
//= require lib/vendor/jquery.autoresize
//= require lib/vendor/jquery.autogrow
//= require lib/vendor/jquery.tags
//= require lib/vendor/jquery.chosen
//= require lib/vendor/jquery.tipsy
//= require lib/vendor/ss-standard
//= require lib/vendor/ss-social
//= require lib/noted.contributors
//= require lib/noted.tags

$(document).ready ->
  $("#user aside h2").fitText 1.1

  $("select.chosen").chosen();

  $(".description h4 a.expand").on "click", ->
    if $(".description .text").hasClass("hidden")
      $(".description .text").removeClass("hidden").addClass("display")
    else
      $(".description .text").removeClass("display").addClass "hidden"

  $(".tabs").tabs()

  $(".tooltip").tipsy gravity: $.fn.tipsy.autoNS
