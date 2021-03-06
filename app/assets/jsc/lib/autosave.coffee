# Noted.
#   file: lib/autosave.coffee

root = exports ? this

root.save = ->
  data = {
    csrf: $("input[name=authenticity_token]").val()
    current_user: $(".current_user").val()
    note: {
      id: $(".note-id").val()
      title: $(".note-title").val()
      tags: $(".note-tags").val()
      text: $(".note-text").html()
    }
    ajax: true
  }

  $.ajax
    type: "PATCH"
    data: data
    url: "/notes/#{data.note.id}"
    statusCode:
      200: ->
        $("span.message").html "Saved!"
        $("span.message").fadeIn()

        setTimeout (->
          $("span.message").fadeOut()
          $("span.message").val ""
        ), 3000
      500: ->
        $("span.message").addClass "fail"
        $("span.message").fadeIn()
        $("span.message").html "Failed to save!"
    error: (err) ->
      $("span.message").addClass "fail"
      $("span.message").fadeIn()
      $("span.message").html "Failed to save!"

  return

timer = 0
$(".note-text, .note-title, .selectize-input input").on "keyup", (e) ->
  clearTimeout timer if timer

  timer = setTimeout root.save, 400

  return

$(".note-submit").on "click", ->
  save()
