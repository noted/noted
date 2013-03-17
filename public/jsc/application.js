(function() {

  $(document).ready(function() {
    var editor, opts, updateEditorHeight;
    $("#user aside h2").fitText(1.1);
    opts = {
      container: 'epiceditor',
      basePath: '/jsc/lib/epiceditor/epiceditor',
      file: {
        name: 'epiceditor',
        defaultContent: '',
        autoSave: 100
      },
      theme: {
        base: '/jsc/lib/epiceditor/epiceditor/themes/base/epiceditor.css'
      }
    };
    editor = new EpicEditor(opts);
    updateEditorHeight = function() {
      var editorHeight;
      editorHeight = $(editor.getElement("editor").body).height();
      $("#epiceditor").height(editorHeight + 20);
      return editor.reflow();
    };
    editor.load(function() {
      return updateEditorHeight();
    });
    editor.on("update", function() {
      return updateEditorHeight();
    });
    return $("a.preview").onclick = function() {
      return editor.preview();
    };
  });

}).call(this);
