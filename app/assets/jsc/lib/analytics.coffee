###
# Google Analytics
###
((i, s, o, g, r, a, m) ->
  i["GoogleAnalyticsObject"] = r
  i[r] = i[r] or ->
    (i[r].q = i[r].q or []).push arguments

  i[r].l = 1 * new Date()

  a = s.createElement(o)
  m = s.getElementsByTagName(o)[0]

  a.async = 1
  a.src = g
  m.parentNode.insertBefore a, m
) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"
ga "create", "UA-37963617-2", "getnotedapp.com"
ga "send", "pageview"

###
# Segment.io
###
analytics = analytics or []

# Define a method that will asynchronously load analytics.js from our CDN.
analytics.load = (apiKey) ->

  # Create an async script element for analytics.js.
  script = document.createElement("script")
  script.type = "text/javascript"
  script.async = true
  script.src = ((if "https:" is document.location.protocol then "https://" else "http://")) + "d2dq2ahtl5zl1z.cloudfront.net/analytics.js/v1/" + apiKey + "/analytics.min.js"

  # Find the first script element on the page and insert our script next to it.
  firstScript = document.getElementsByTagName("script")[0]
  firstScript.parentNode.insertBefore script, firstScript

  # Define a factory that generates wrapper methods to push arrays of
  # arguments onto our `analytics` queue, where the first element of the arrays
  # is always the name of the analytics.js method itself (eg. `track`).
  methodFactory = (type) ->
    ->
      analytics.push [type].concat(Array::slice.call(arguments_, 0))


  # Loop through analytics.js' methods and generate a wrapper method for each.
  methods = ["identify", "track", "trackLink", "trackForm", "trackClick", "trackSubmit", "pageview", "ab", "alias", "ready", "group"]
  i = 0

  while i < methods.length
    analytics[methods[i]] = methodFactory(methods[i])
    i++


# Load analytics.js with your API key, which will automatically load all of the
# analytics integrations you've turned on for your account. Boosh!
analytics.load "4aqym02jj4"
