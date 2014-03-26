# Noted
#   file: jsc/lib/filter.coffee

$(document).ready ->
  refresh_view()


$(".tag").on "click", ->
  filter_toggle($(@))

$ ->
  $(window).hashchange ->
    refresh_view()

# Call on click of tag, add or remove filter
filter_toggle = (e) ->
  if e.attr("data-selected") == "true"
    remove_filter(e, e.attr("data-selected"))
  else
    add_filter(e, e.attr("data-selected"))

  refresh_view()


# Add a new filter
add_filter = (toggle, filter) ->
  toggle = $(toggle)

  filters = get_filters()
  filters.push(toggle.attr('data-value'))

  fragment = "#filters=#{filters}"

  location.hash = fragment


# Remove a filter
remove_filter = (toggle, filter) ->
  toggle = $(toggle)

  filters = get_filters()
  filters = _.without(filters, toggle.attr('data-value'))

  if filters.length == 0
    fragment = ""
  else
    fragment = "#filters=#{filters}"

  location.hash = fragment


# Get the current filters
get_filters = ->
  if get_hash_params().filters == undefined
    filters = []
  else
    filters = get_hash_params().filters.split(",")

  return filters


# Get the tagged objects
get_tagged = ->
  $('*[data-tags]')


# Get the filter toggles
get_toggles = ->
  $('.tag')


# Refresh the current view based on the current filters
refresh_view = ->
  filters = get_filters()
  toggles = get_toggles()
  tagged  = get_tagged()

  toggles.each (i, e) ->
    if check_if_select_toggle(e, filters)
      $(e).attr('data-selected', true)
    else
      $(e).attr('data-selected', false)

  tagged.each (i, e) ->
    if check_if_show_object(e, filters)
      $(e).show()
    else
      $(e).hide()

  # for each toggle, check_if_select_toggle()
  # for each object, check_if_show_object()


# Checks if a tag toggle should highlight or not
check_if_select_toggle = (e, filters) ->
  toggle = $(e)

  return false if filters is []

  value = toggle.attr('data-value')

  return filters.indexOf(value) > -1


# Checks if an object should show or not
check_if_show_object = (e, filters) ->
  obj = $(e)

  # If there aren't any filters, show everything
  if filters.length == 0
    return true

  # If there are filters, and there aren't any tags, don't sohw it
  if filters.length > 0 and !obj.attr('data-tags')
    return false

  # Check for similarities between the tags and filters
  tags = obj.attr('data-tags').split(',')

  overlap = $(filters).not($(filters).not(tags).get()).get()

  # If array of overlap (i.e., there's a filter and tag that are the same), return true
  return overlap.length > 0


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
