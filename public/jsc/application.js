(function() {

  $(document).ready(function() {
    $("#user aside h2").fitText(1.1);
    return $(".description h4 a.expand").on("click", function() {
      if ($(".description .text").hasClass("hidden")) {
        return $(".description .text").removeClass("hidden").addClass("display").slide;
      } else {
        return $(".description .text").removeClass("display").addClass("hidden");
      }
    });
  });

}).call(this);
