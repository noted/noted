# Noted.
#   file: lib/autosave.coffee

save = ->
  console.log 'save'
  return

timer = 0
$('.note-show input, .note-show .note-text').on "keyup", (e) ->
  clearTimeout timer  if timer
  timer = setTimeout(save, 400)
  return
