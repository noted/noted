(function() {
  var save;

  $("form.note.ajax button").on("click", function(e) {
    e.preventDefault();
    $("span.status").html("Saving...");
    return save();
  });

  if ($("form.note.ajax").length) {
    setInterval((function() {
      return save();
    }), 30000);
  }

  save = function() {
    var data;

    $("span.status").html("Saving...");
    data = {
      author: $("form.note .author").val(),
      note: {
        id: $("form.note .id").val(),
        title: $("form.note .title").val(),
        body: $("form.note .body").val(),
        tags: $("form.note input[name='note[tags]']").val(),
        source_ids: $("form.note .sources").val()
      }
    };
    return $.ajax({
      type: 'PATCH',
      data: data,
      url: '/api/notes/update.json',
      error: function(err) {
        console.log(err);
        $("span.status").addClass("error");
        $("span.status").html("Failed to save!");
        return $("span.status").fadeIn();
      },
      success: function(res) {
        $("span.status").html("Saved!");
        $("span.status").fadeIn();
        return setTimeout((function() {
          $("span.status").fadeOut();
          return $("span.status").val("");
        }), 10000);
      }
    });
  };

}).call(this);
