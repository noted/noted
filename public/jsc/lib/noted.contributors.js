(function() {
  $(document).ready(function() {
    $("a.add").on("click", function() {
      var num, param, type;

      num = $("ul.contributors li").first().attr("data-num");
      num++;
      type = $("ul.contributors li").first().attr("data-type");
      param = "" + type + "[contributors][" + num + "]";
      return $("ul.contributors").append("<li data-num='" + num + "' data-type='" + type + "'>                                  <select name='" + param + "[role]'>                                  <option value='author'>Author</option>                                  <option value='editor'>Editor</option>                                  <option value='translator'>Translator</option>                                  <option value='compiler'>Compiler</option></select>                                  <input class='first' placeholder='John' name='" + param + "[first]' type='text' />                                  <input class='middle' placeholder='Q' maxlength='1' name='" + param + "[middle]' type='text' />                                  <input class='last' placeholder='Sample' name='" + param + "[last]' type='text' />                                  <input class='suffix' placeholder='Jr' name='" + param + "[suffix]' type='text' />                                  <a class='remove' data-action='remove'><i class='ss-icon'>delete</i></a>                                </li>");
    });
    return $("a.remove").live("click", function() {
      return $(this).parent().remove();
    });
  });

}).call(this);
