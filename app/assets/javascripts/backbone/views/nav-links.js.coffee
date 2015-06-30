class Greenback.Views.NavLinks extends Greenback.Views.Base
  template: JST["backbone/templates/user-nav-links"]
  template2: JST["backbone/templates/default-nav-links"]

  tagName     : "div"
  className   : "navigation-bar--container container"
  id          : ""
  attributes  : {}

  events: {
    "click [js-toggle-navigation-dropdown]": "toggleDropdown"
  }

  initialize: =>
    @model.on "reset", @render, this
    @model.on "change", @render, this

    @model.fetch()

  toggleDropdown: =>
    @$("[js-navigation-dropdown]").toggleAttr "s-visible"
    @$("[js-toggle-navigation-dropdown]").toggleAttr "s-active"

  render: =>
    if @model
      @$el.html @template { user: @model.toJSON() }
    else
      @$el.html @template2()

    this
