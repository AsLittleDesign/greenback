class Greenback.Views.Nav extends Greenback.Views.Base
  template: JST["backbone/templates/nav"]
  tagName: "nav"
  className: "navigation-bar"
  id: ""
  attributes:
    "js-nav-bar": ""

  events:
    "contextmenu [js-logo]": "toggleLogoModal"
  
  initialize: =>
    # Initialize event handler for navigation scroll effects
    $(window).bind "mousewheel": (e) =>
      @toggleNav(e)

    @model.on("reset", @render, this)
    @render()
  
  toggleNav: _.throttle (e) ->
    if e.originalEvent.wheelDelta > 0
      @$el.removeAttr "s-nav-up"

    else if $(window).scrollTop() > 150
      @$el.attr "s-nav-up", true

      if @$("[js-navigation-dropdown]").attr "s-visible"
        @$("[js-navigation-dropdown]").toggleAttr  "s-visible"
  , 150

  toggleLogoModal: (e) =>
    e.preventDefault()
    @showModal @$("#logo-modal[js-modal]")

  render: =>
    @$el.html @template()
    navLinks = new Greenback.Views.NavLinks(model: @model)
    @$el.append navLinks.render().el

    this