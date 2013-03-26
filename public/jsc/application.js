(function() {

  jQuery.removeFromArray = function(value, arr) {
    return jQuery.grep(arr, function(elem, index) {
      return elem !== value;
    });
  };

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
        $("header ul.tags").append('<li data-value="' + $(this).text() + '"><span class="btn">' + $(this).text() + ' <a href="#"><i class="ss-icon">close</i></a></span></li>');
      }
      return console.log(tags);
    });
    $("header ul.tags a").on('click', function() {
      console.log("go");
      $.removeFromArray($(this).attr("data-value"), tags);
      console.log(tags);
      return $(this).parent().parent().remove();
    });
    $("header ul.tags li span").on('click', "header ul.tags li span", function() {
      return console.log("foo");
    });
    return $("a").on("click", function() {
      return console.log("fo");
    });
  });

}).call(this);
