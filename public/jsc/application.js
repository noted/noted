(function() {
  $(document).ready(function() {
    ligature(false, $(".text"));
    $("#user aside h2").fitText(1.1);
    $("select.chosen").chosen();
    $(".description h4 a.expand").on("click", function() {
      if ($(".description .text").hasClass("hidden")) {
        return $(".description .text").removeClass("hidden").addClass("display");
      } else {
        return $(".description .text").removeClass("display").addClass("hidden");
      }
    });
    $(".tabs").tabs();
    $(".tooltip").tipsy({
      gravity: $.fn.tipsy.autoNS
    });
    $(".redactor").redactor({
      autoresize: false,
      minHeight: 200,
      source: true
    });
    $(".tabs.note ul li.view a").on("click", function() {
      return $("#view .text").html($(".redactor").getCode());
    });
    return $(".suggest").autocomplete({
      serviceUrl: "/api/users/search.json",
      minChars: 3
    });
  });

}).call(this);
