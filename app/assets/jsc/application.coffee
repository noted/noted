$(document).ready ->
  $("#user aside h2").fitText 1.1

  $("select.chosen").chosen();

  $(".description h4 a.expand").on "click", ->
    if $(".description .text").hasClass("hidden")
      $(".description .text").removeClass("hidden").addClass("display")
    else
      $(".description .text").removeClass("display").addClass "hidden"


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

  # TAGS
  $('input.tags').tagsManager
    hiddenTagListName: 'note[tags]'

  arr = $('input[name="existing-tags"]').attr('value')

  if arr
    arr = arr.split(",")
    for i of arr
      $('input.tags').tagsManager('pushTag', arr[i])

  $("input.tags").autoGrowInput
    comfortZone: 20
    minWidth: 200
    maxWidth: 900

  $(".textbox footer").click ->
    $(".textbox footer input").focus()


  tags = []

  # If tag in note is clicked
  $("footer ul.tags li a").on 'click', ->
    # Unless the tag is already in the array
    unless tags.indexOf($(this).text()) != -1
      # Add it to the array
      tags.push($(this).text())

      # Put it in the header
      for tag in tags
        $("header ul.tags").append '<li data-value="' + tag + '"><span class="btn">' + tag + ' <a><i class="ss-icon">close</i></a></span></li>'

      # Loop through each note
      $("article.note").each ->
        # Build array of that note's tags
        noteTags = $(this).attr("data-tags").split(",") unless $(this).attr("data-tags") == ""

        # If noteTags does not include an element in tags, hide it
        num = 0
        for tag in tags
          num = num + noteTags.indexOf(tag)

        if num < 0
          $(this).hide()

  # If tag in header is clicked
  $("header ul.tags").on 'click', 'li span', ->
    tag = $(this).parent().attr("data-value")

    # Remove from array
    tags = _.without tags, tag

    # Rebuild list in header
    $("header ul.tags").empty()
    for tag in tags
      $("header ul.tags").append '<li data-value="' + tag + '"><span class="btn">' + tag + ' <a><i class="ss-icon">close</i></a></span></li>'

    # Un-hide hidden elements
    $("article.note").each ->
      $(this).show()

      # Build array of that note's tags
      noteTags = $(this).attr("data-tags").split(",") unless $(this).attr("data-tags") == ""

      # If noteTags does not include an element in tags, hide it
      num = 0
      for tag in tags
        num = num + noteTags.indexOf(tag)

      if num < 0
        $(this).hide()

