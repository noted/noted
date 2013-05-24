$("form.note.ajax button").on "click", (e) ->
  e.preventDefault()

  console.log 'Clicked Save'

  $("span.status").html("Saving...")

  save()

if $("form.note.ajax").length
  setInterval (->
    save()
  ), 30000

save = ->
  $("span.status").html("Saving...")

  data = {
    author: $("form.note .author").val()
    note: {
      id: $("form.note .id").val()
      title: $("form.note .title").val()
      body: $("form.note .body").val()
      tags: $("form.note input[name='note[tags]']").val()
      source_ids: $("form.note .sources").val()
    }
  }

  $.ajax
    type: 'PATCH'
    data: data
    url: '/api/notes/update.json'
    error: (err) ->
      console.log err

      $("span.status").addClass "error"
      $("span.status").html "Failed to save!"
    success: (res) ->
      $("span.status").html "Saved!"

      setTimeout (->
        $("span.status").fadeOut()
        $("span.status").val ""
      ), 10000
