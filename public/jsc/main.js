(function() {
  var dependencies;

  dependencies = ["jquery", "underscore", "jquery.fittext", "jquery.autoresize", "jquery.autogrow", "jquery.tags", "jquery.chosen", "jquery.tipsy", "noted.tags", "noted.contributors"];

  require(dependencies, function($) {
    return $(function() {
      return $(document).ready(function() {
        $("#user aside h2").fitText(1.1);
        $("select.chosen").chosen();
        $(".description h4 a.expand").on("click", function() {
          if ($(".description .text").hasClass("hidden")) {
            return $(".description .text").removeClass("hidden").addClass("display");
          } else {
            return $(".description .text").removeClass("display").addClass("hidden");
          }
        });
        return $(".tooltip").tipsy({
          gravity: $.fn.tipsy.autoNS
        });
      });
    });
  });

}).call(this);
