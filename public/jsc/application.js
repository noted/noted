(function() {

  $(document).ready(function() {
    var arr, i, tags;
    $("#user aside h2").fitText(1.1);
    $(".description h4 a.expand").on("click", function() {
      if ($(".description .text").hasClass("hidden")) {
        return $(".description .text").removeClass("hidden").addClass("display");
      } else {
        return $(".description .text").removeClass("display").addClass("hidden");
      }
    });
    $('input.tags').tagsManager({
      hiddenTagListName: 'note[tags]'
    });
    arr = $('input[name="existing-tags"]').attr('value');
    if (arr) {
      arr = arr.split(",");
      for (i in arr) {
        $('input.tags').tagsManager('pushTag', arr[i]);
      }
    }
    $("input.tags").autoGrowInput({
      comfortZone: 20,
      minWidth: 200,
      maxWidth: 900
    });
    $(".textbox footer").click(function() {
      return $(".textbox footer input").focus();
    });
    tags = [];
    $("footer ul.tags li a").on('click', function() {
      if (tags.indexOf($(this).text()) === -1) {
        tags.push($(this).text());
        $("header ul.tags").append('<li data-value="' + $(this).text() + '"><span class="btn">' + $(this).text() + ' <a><i class="ss-icon">close</i></a></span></li>');
        return $("article.note").each(function() {
          var noteTags, num, tag, _i, _len;
          if ($(this).attr("data-tags") !== "") {
            noteTags = $(this).attr("data-tags").split(",");
          }
          num = 0;
          for (_i = 0, _len = tags.length; _i < _len; _i++) {
            tag = tags[_i];
            num = num + noteTags.indexOf(tag);
          }
          if (num < 0) {
            return $(this).hide();
          }
        });
      }
    });
    return $("header ul.tags").on('click', 'li span', function() {
      var tag;
      tag = $(this).parent().attr("data-value");
      tags = _.without(tags, tag);
      $(this).parent().parent().remove();
      if (tags.length === 0) {
        return $("article.notes").each(function() {
          return $(this).show();
        });
      }
    });
  });

}).call(this);
