# Noted.
#   file: jsc/noted.contributors.coffee

$(document).ready ->
  $("a.add").on "click", ->
    num = $("ul.contributors li").first().attr("data-num")
    num++

    type = $("ul.contributors li").first().attr("data-type")

    param = "#{type}[contributors][#{num}]"

    $("ul.contributors").append("<li data-num='#{num}' data-type='#{type}'>
                                  <select name='#{param}[role]'>
                                  <option value='author'>Author</option>
                                  <option value='editor'>Editor</option>
                                  <option value='translator'>Translator</option>
                                  <option value='compiler'>Compiler</option></select>
                                  <input class='first' placeholder='John' name='#{param}[first]' type='text' />
                                  <input class='middle' placeholder='Q' maxlength='1' name='#{param}[middle]' type='text' />
                                  <input class='last' placeholder='Sample' name='#{param}[last]' type='text' />
                                  <input class='suffix' placeholder='Jr' name='#{param}[suffix]' type='text' />
                                </li>")

  $("ul.contributors li a.remove").on "click", ->
    console.log $(this).parent()
    $(this).parent().remove()
