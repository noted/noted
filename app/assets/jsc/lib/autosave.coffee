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
    error: (err) ->
      $('span.message').addClass 'fail'
      $('span.message').html 'Failed to save!'

      console.log err
    success: (res) ->
      $('span.message').html 'Saved!'

  return

timer = 0
$('.note-text, .note-title, .selectize-input input').on "keyup", (e) ->
  clearTimeout timer  if timer
  timer = setTimeout(root.save, 400)
  return
