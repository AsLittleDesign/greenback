#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Greenback =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
  	new Greenback.Routers.Base()
  	Backbone.history.start({pushState:true})

$ ->
  Greenback.init()

  $(document).on "click", "a:not([data-bypass])", (e) ->
    href = $(this).attr "href"
    protocol = @protocol + "//"
    if href and href.slice(0, protocol.length) != protocol and href.indexOf("javascript:") != 0
      e.preventDefault();
      Backbone.history.navigate(href, true)
