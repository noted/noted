dependencies = [
  "jquery"
  "underscore"
  "jquery.ui"
  "jquery.fittext"
  "jquery.autoresize"
  "jquery.autogrow"
  "jquery.tags"
  "jquery.chosen"
  "jquery.tipsy"
  "noted.tags"
  "noted.contributors"
]

require dependencies, ($) ->
  $ ->
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
