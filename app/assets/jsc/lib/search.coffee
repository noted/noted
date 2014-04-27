# Noted
#   file: jsc/lib/search.coffee

$(document).ready ->
  refresh_view()

typing_timer = null
done_typing_interval = 5000

$(".search").keyup ->
  clearTimeout(typing_timer)
  if ($('.search').val)
    typing_timer = setTimeout(change_search_hash(), done_typing_interval)

$ ->
  $(window).hashchange ->
    refresh_view()

# Change the hash
change_search_hash = ->
  query = $('.search').val()

  location.hash = "#search=#{query}"

  make_request()

# Make the search request
make_request = ->
  console.log get_hash_params().search

  query = get_hash_params().search

  current_path = location.pathname
  current_path = current_path.split('/')
  search_url = "/#{current_path[1]}/#{current_path[2]}/notes/search?query=#{query}"

  $.ajax(
    type: "GET"
    url: search_url
  ).done (data) ->
    refresh_view(data.results)

refresh_view = (ids) ->
  # loop through notes, running check_if_show_object on each

  $('.note').each ->
    check_if_show_object(@, ids)

# Checks if an object should show or not
check_if_show_object = (e, ids) ->
  obj = $(e)

  console.log e.attr('data-nid')
  console.log ids

  if ids.indexOf(e.attr('data-id')) > -1
    obj.show()
  else
    obj.hide()


# Get the current parameters int he hash
get_hash_params = ->
  hash_params = {}
  e = undefined
  a = /\+/g # Regex for replacing addition symbol with a space
  r = /([^&;=]+)=?([^&;]*)/g
  d = (s) ->
    decodeURIComponent s.replace(a, " ")

  q = window.location.hash.substring(1)
  hash_params[d(e[1])] = d(e[2])  while e = r.exec(q)
  hash_params
