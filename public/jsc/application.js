(function() {

  $(document).ready(function() {
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
    $("input.tags").autoGrowInput({
      comfortZone: 20,
      minWidth: 200,
      maxWidth: 960
    });
    return $(".textbox footer").click(function() {
      return $(".textbox footer input").focus();
    });
  });

}).call(this);
