$(document).ready ->
  $("#user aside h2").fitText 1.1
  #$('textarea').autoResize();

  opts = {
    container: 'epiceditor',
    basePath: '/jsc/lib/epiceditor/epiceditor',
    file: {
      name: 'epiceditor',
      defaultContent: '',
      autoSave: 100
    },
    theme: {
      base:'/jsc/lib/epiceditor/epiceditor/themes/base/epiceditor.css'
    }
  }

  editor = new EpicEditor(opts)

  updateEditorHeight = ->
    editorHeight = $(editor.getElement("editor").body).height()

    # +20 for padding
    $("#epiceditor").height editorHeight + 20
    editor.reflow()

  editor.load ->
    updateEditorHeight()

  editor.on "update", ->

    # You should probably put a check here so it doesn't
    # run for every update, but just on update, AND if the
    # element's height is different then before.
    updateEditorHeight()

  $("a.preview").onclick = ->
    editor.preview()
