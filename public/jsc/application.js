(function() {

  $(document).ready(function() {
    var arr, i;
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
    arr = $('input[name="existing-tags"]').attr('value').split(",");
    for (i in arr) {
      $('input.tags').tagsManager('pushTag', arr[i]);
    }
    $("input.tags").autoGrowInput({
      comfortZone: 20,
      minWidth: 200,
      maxWidth: 900
    });
    return $(".textbox footer").click(function() {
      return $(".textbox footer input").focus();
    });
  });

}).call(this);
